From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 03/12]  media: Entities,
 pads and links
Date: Thu, 25 Nov 2010 15:28:28 +0000
Message-ID: <20101125152827.GH22298@rakim.wolfsonmicro.main>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1290652099-15102-4-git-send-email-laurent.pinchart@ideasonboard.com>
	<4CEE2E7D.6060608@ladisch.de>
	<201011251621.38757.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <201011251621.38757.laurent.pinchart@ideasonboard.com>
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
Cc: alsa-devel@alsa-project.org, sakari.ailus@maxwell.research.nokia.com, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, lennart@poettering.net, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 25, 2010 at 04:21:38PM +0100, Laurent Pinchart wrote:
> On Thursday 25 November 2010 10:38:05 Clemens Ladisch wrote:

> > ALSA has PCM and MIDI devices, and several types of mixer controls.
> > (It also has hardware dependent and timer devices, but I don't think
> > these would need topology information.)  So we need at least these:
> >   MEDIA_ENTITY_TYPE_NODE_ALSA_PCM
> >   MEDIA_ENTITY_TYPE_NODE_ALSA_MIDI
> >   MEDIA_ENTITY_TYPE_SUBDEV_ALSA_CONTROL

> I agree about PCM and MIDI, but I'm not sure about controls. If controls are 
> part of an entity, the entity will be reported through the media controller 
> API. If information about that entity can be queried through existing APIs 
> (ALSA, V4L, ...) those APIs should be used. For instance, on the V4L side, 
> V4L2 sub-devices are mapped to entities and also have a device node which can 
> be used to enumerate the controls supported by the subdev. The media 
> controller only reports the entity -> major:minor mapping to let applications 
> find the device and query it directly.

For audio we don't currently have a sensible API for associating
controls with any sort of map of how the device is laid out, userspace
has to play guessing games.

> I think we will need a new ioctl in the media controller API to report 
> advanced information about an entity. This could be used to report controls 
> implemented by an ALSA element if ALSA doesn't provide a way to do that 
> directly. Another use case, which make me think that such an ioctl would be 
> needed, is to report UVC extension units type (16-byte GUID) to userspace.

That seems reasonable.
