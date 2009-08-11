From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [alsa-devel] [PATCH 11/20] OMAP: McBSP: Add link DMA mode
 selection
Date: Tue, 11 Aug 2009 09:18:01 +0300
Message-ID: <1249971481.16045.17.camel@eenurkka-desktop>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	 <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	 <20090805103900.5ad89efe.jhnikula@gmail.com>
	 <200908051158.57440.peter.ujfalusi@nokia.com>
	 <1FFEF31EBAA4F64B80D33027D4297760047F6AED01@NOK-EUMSG-02.mgdnok.nokia.com>
	 <20090811090457.d89afd3e.jhnikula@gmail.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23766 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbZHKMIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 08:08:54 -0400
In-Reply-To: <20090811090457.d89afd3e.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

On Tue, 2009-08-11 at 08:04 +0200, ext Jarkko Nikula wrote:
> Sorry for the late reply.
> 
> On Thu, 6 Aug 2009 20:15:40 +0200
> <ext-Eero.Nurkkala@nokia.com> wrote:
> 
> > Well, the element mode is fine for !McBSP2. One doesn't really loose the
> > buffer pointer accuracy, because you can get the last DMA irq timestamp
> > with SNDRV_PCM_IOCTL_TTSTAMP (and compare that to current time).
> > The accuracy is not far off from the element mode? (If you read the DMA
> > portion of TRM, I think there were some issues as well)
> > 
> Well the threshold mode makes the offset returned from omap_pcm_pointer
> to behave gradually as the threshold size is set. This would affect a SW
> which is doing sub-period processing like mixing audio n samples ahead
> the current DMA pointer. Of course HW buffer in McBSP2 adds static
> latency but otherwise processing is similar compared to other ports and
> OMAPs.
> 
> I would like to see this new threshold based transfer functionality to
> be integrated so that projects can take the advantage of it and helps
> generic PM development too but I don't want that it would cause any
> regression now. Later on it is easy to switch threshold based transfer
> to be the default for McBSP2 on OMAP3 but it's safer to keep current
> mode default over one kernel release.
> 

What regression are you addressing to? Of course in OMAP2s there could
be issues I'm not aware of. But does this have any effect on them?
(isn't this only OMAP3).

There's regression indeed with McBSP2 as it is. The same regression is
available for you, even with the element mode; See, the problem is the
large HW buffer, and I think there's efforts to fix those issues; for
example: http://bugzilla.gnome.org/show_bug.cgi?id=545807
That is causing the "known regression", it's not really the
threshold/dma mode. (of course I'm probably not aware of all)

If one wishes to perform runtime mixing of several channels etc, it's
known to the men in the art that of course the McBSP buffer latency, was
it in element or threshold mode, is required to be calculated so that
the time until the sample is played, need to be considered. That can be
done easily with either of the threshold/element mode.

DMA transfers may also have delays due to DMA controller scheduling
(other channels present). Thus, there's always some unpredictable, but
rather tiny, delays.


> > For !McBSP2, it doesn't even pay to have the threshold mode at all, because
> > the effect on PM is actually adverse - too frequent wakeups will cause more
> > adverse net effect on PM (IIRC) @ VBAT.
> > 
> This is good information and integrating these functionalities allow to
> collect more. Without regression of course :-)
> 
> 

