From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC/PATCH v6 03/12]  media: Entities,
	pads and links
Date: Fri, 26 Nov 2010 10:10:54 +0100
Message-ID: <4CEF799E.7060508@ladisch.de>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1290652099-15102-4-git-send-email-laurent.pinchart@ideasonboard.com>
	<4CEE2E7D.6060608@ladisch.de>
	<201011251621.38757.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@alsa-project.org, sakari.ailus@maxwell.research.nokia.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lennart@poettering.net, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Laurent Pinchart wrote:
> On Thursday 25 November 2010 10:38:05 Clemens Ladisch wrote:
> >   MEDIA_ENTITY_TYPE_NODE_ALSA_PCM
> >   MEDIA_ENTITY_TYPE_NODE_ALSA_MIDI
> >   MEDIA_ENTITY_TYPE_SUBDEV_ALSA_CONTROL
> 
> I agree about PCM and MIDI, but I'm not sure about controls. If controls are
> part of an entity, the entity will be reported through the media controller
> API. If information about that entity can be queried through existing APIs
> (ALSA, V4L, ...) those APIs should be used.

At the moment, ALSA has no API for topology information.

> I can certainly imagine a graph with 100 controls, but maybe several
> controls can be part of the same node ?

There is indeed no strict 1:1 relation; e.g., volume and mute are often
part of the same node.  So it looks we need some kind of separate ALSA
node, which can be associated with mixer controls and/or other
information.

ALSA already has is a method to query arbitrary (TLV) metadata for mixer
controls; the entity/control relationship can be stored in the control.

> I think we will need a new ioctl in the media controller API to report
> advanced information about an entity. This could be used to report controls
> implemented by an ALSA element if ALSA doesn't provide a way to do that
> directly.

This advanced information would always be specific to the entity type,
so maybe this should be part of that subsystem's API.  Otherwise, the
media_entity would need a callback, or store a pointer to some memory
block (which assumes that the information is always constant).

> > Furthermore, topology information is also needed for entities not
> > associated with a mixer control, such as microphones, speakers, jacks/
> > connectors, and effect units.  These entities are defined in the USB and
> > HD audio specifications, but are not yet handled by ALSA.
> 
> Agreed, we will need to add new entity types and subtypes for those. The
> reason they're not part of this submission is that I wanted real use cases
> instead of coming up with a made-up list of entities I think would be useful.

The reason that I'm always mentioning the USB and HD audio specs is that
those already define entities that should cover practically all of the
audio needs.  (And, of course, we want to be able to report those
entities without having to do too many conversions.)


I'll see if I can draw up the ALSA-specific media stuff over the weekend.


Regards,
Clemens
