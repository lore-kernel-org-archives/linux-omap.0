From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC/PATCH v6 03/12]  media: Entities,
	pads and links
Date: Thu, 25 Nov 2010 10:38:05 +0100
Message-ID: <4CEE2E7D.6060608@ladisch.de>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1290652099-15102-4-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1290652099-15102-4-git-send-email-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: alsa-devel@alsa-project.org, sakari.ailus@maxwell.research.nokia.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lennart@poettering.net, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Laurent Pinchart wrote:
> A link is a point-to-point oriented connection between two pads, either
> on the same entity or on different entities. Data flows from a source
> pad to a sink pad.
> 
> Links are stored in the source entity.

In the descriptors of USB Audio and HDAudio devices, the links are
stored only in the sink.  But AFAICS this doesn't matter in the media
driver API.

> +Links have flags that describe the link capabilities and state.
> +
> +	MEDIA_LINK_FLAG_ACTIVE indicates that the link is active and can be
> +	used to transfer media data. When two or more links target a sink pad,
> +	only one of them can be active at a time.
> +	MEDIA_LINK_FLAG_IMMUTABLE indicates that the link active state can't
> +	be modified at runtime. If MEDIA_LINK_FLAG_IMMUTABLE is set, then
> +	MEDIA_LINK_FLAG_ACTIVE must also be set since an immutable link is
> +	always active.

So the intended userspace API for controlling routing is to change the
ACTIVE flag of links?

In USB and HD audio devices, all links are immutable, and the routing
is controlled by 'selector' entities that activate exactly one of their
input pads.  In userspace, this entity shows up as a mixer control.
I guess it would be possible to map the ACTIVE flag onto these controls.

Alternatively, entities can have 'mute' mixer controls associated with
their pads.  In this case, multiple unmuted inputs would be mixed
together.

> +#define MEDIA_ENTITY_TYPE_MASK               0x00ff0000
> +#define MEDIA_ENTITY_SUBTYPE_MASK            0x0000ffff
> +
> +#define MEDIA_ENTITY_TYPE_NODE               (1 << MEDIA_ENTITY_TYPE_SHIFT)
> ...
> +#define MEDIA_ENTITY_TYPE_NODE_ALSA          (MEDIA_ENTITY_TYPE_NODE + 3)

ALSA has PCM and MIDI devices, and several types of mixer controls.
(It also has hardware dependent and timer devices, but I don't think
these would need topology information.)  So we need at least these:
  MEDIA_ENTITY_TYPE_NODE_ALSA_PCM
  MEDIA_ENTITY_TYPE_NODE_ALSA_MIDI
  MEDIA_ENTITY_TYPE_SUBDEV_ALSA_CONTROL

Furthermore, topology information is also needed for entities not
associated with a mixer control, such as microphones, speakers, jacks/
connectors, and effect units.  These entities are defined in the USB and
HD audio specifications, but are not yet handled by ALSA.

> +struct media_entity {
> ...
> +	union {
> +		/* Node specifications */
> +		struct {
> +			u32 major;
> +			u32 minor;
> +		} v4l;
> +		struct {
> +			u32 major;
> +			u32 minor;
> +		} fb;
> +		int alsa;
> +		int dvb;
> +
> +		/* Sub-device specifications */
> +		/* Nothing needed yet */
> +	};

ALSA devices are not addressed by their device node but with card/device/
subdevice numbers; mixer controls have numeric IDs, unique per card:

		struct {
			int card;
			int device;
			int subdevice;
		} alsa_device;
		struct {
			int card;
			int numid;
		} alsa_control;


Regards,
Clemens
