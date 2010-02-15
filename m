From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 00/17] OMAP DSS2 model restructuring
Date: Mon, 15 Feb 2010 09:45:24 +0200
Message-ID: <1266219924.2433.353.camel@tubuntu.research.nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
	 <6ed0b2681002130734k77de274fx5ceb169e0853b58d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39899 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab0BOHm0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 02:42:26 -0500
In-Reply-To: <6ed0b2681002130734k77de274fx5ceb169e0853b58d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Sat, 2010-02-13 at 16:34 +0100, ext Grazvydas Ignotas wrote:
> On Mon, Feb 8, 2010 at 5:57 PM, Tomi Valkeinen <tomi.valkeinen@nokia.com> wrote:
> > Here are a bunch of patches that change the DSS2 driver's driver model a bit.
> > This change was triggered by trying to support new hardware, and realizing that
> > the current model just won't work.
> >
> > Currently the omapdss driver is in control of most aspects of the DSS, and
> > omapdss calls necessary functions in display drivers. I made it that way to
> > keep the display drivers simple, and I, naively, thought that it will work
> > because the display panels are using standard bus interfaces and thus will be
> > very similar. I was so wrong =).
> >
> > This patch set moves the control to the display driver. The display driver then
> > calls omapdss functions to perform whatever deed is needed at that time. This
> > will make display drivers slightly more complex, but it will be easier to
> > control the hardware properly with strange or complex display devices.
> >
> > As a simple example, let's look at the update function.
> >
> > Currently user space app issues OMAPFB_UPDATE_WINDOW ioctl, and omapfb driver
> > then calls update() in corresponding dss device struct, which goes to omapdss.
> > omapdss will configure the update, calling the panel driver if needed.
> >
> > After these patches, omapfb will call update() in the panel driver. The panel
> > driver will then call functions in omapdss to setup the update, start the
> > update, and the panel driver will eventually get a callback informing that the
> > update is done.
> >
> > These patches are still under work, but my basic tests on 3430SDP board seems
> > to work ok.
> >
> > The patches can also be found from
> > http://gitorious.org/linux-omap-dss2/linux work branch
> 
> Tested those along with the other series, seems to work fine on
> pandora too. Panel callbacks like set_mirror
> also work now, thanks.
> 
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>

Ok, thanks!

 Tomi


