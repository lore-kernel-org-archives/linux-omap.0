From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [Linux-fbdev-devel] [REVIEW PATCH 1/9] DSS: Documentation for
 OMAP2/3 display subsystem
Date: Wed, 05 Nov 2008 12:12:41 +0200
Message-ID: <1225879961.8052.12.camel@tubuntu>
References: <20081104160946.19071.44903.stgit@tubuntu>
	 <20081104160953.19071.49965.stgit@tubuntu>
	 <Pine.LNX.4.64.0811050855180.15985@anakin>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59711 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbYKEKNJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 05:13:09 -0500
In-Reply-To: <Pine.LNX.4.64.0811050855180.15985@anakin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

On Wed, 2008-11-05 at 08:56 +0100, ext Geert Uytterhoeven wrote:
> On Tue, 4 Nov 2008, Tomi Valkeinen wrote:
> > +Sysfs
> > +-----
> > +The sysfs interface is a hack, but works for testing. I don't think sysfs
> > +interface is the best for this in the final version, but I don't quite know
> > +what would be the best interfaces for these things.
> > +
> > +In /sys/devices/platform/omapfb we have four files: framebuffers,
> > +overlays, managers and displays. You can read them so see the current
> > +setup, and change them by writing to it in the form of
> > +"<item-id> <opt1>:<val1> <opt2>:<val2>..."
> > +
> > +"framebuffers" lists all framebuffers. Its format is:
> > +	<fb number>
> > +	t:<target overlay>
> > +
> > +"overlays" lists all overlays. Its format is:
> > +	<overlay name>
> > +	t:<target manager>
> > +	x:<xpos>
> > +	y:<ypos>
> > +	iw:<input width, read only>
> > +	ih:<input height, read only>
> > +	w:<output width>
> > +	h:<output height>
> > +	e:<enabled>
> > +
> > +"managers" lists all overlay managers. Its format is:
> > +	<manager name>
> > +	t:<target display>
> > +
> > +"displays" lists all displays. Its format is:
> > +	<display name>
> > +	w:<width>
> > +	h:<height>
> > +	e:<enabled>
> > +	u:<update mode>
> > +	t:<tear sync on/off>
> 
> As all of these contain lists of sections (one for each
> fb/overlay/manager/display), what about making them directories, with each
> section an individual file?

I've thought that also. The reason for the current form is that it was
simpler to implement, and is not meant to be in the final version. If
the sysfs interface stays there, then I agree that they files have to be
divided.

> 
> Gr{oetje,eeting}s,
> 
> 						Geert

 Tomi

