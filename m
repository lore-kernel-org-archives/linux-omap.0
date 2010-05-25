From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: dss2 for-next BUG at drivers/video/omap2/dss/core.c:323!
Date: Tue, 25 May 2010 15:49:18 +0300
Message-ID: <1274791758.2265.79.camel@tubuntu.research.nokia.com>
References: <AANLkTinS0irEdEzttaHd0n_w5Cs3h6Q44e9sXgcbDmNH@mail.gmail.com>
	 <1274169334.2307.74.camel@tubuntu.research.nokia.com>
	 <AANLkTilySmQn2w0royR2UXltWt4Y94AAU-EYXvny9Se1@mail.gmail.com>
	 <AANLkTikEouEjWyu9De6hAweyEGXx6drV4E18zWyC_CRg@mail.gmail.com>
	 <AANLkTimy4PLEJ7LtnO79nF_NbMUrpIvfhfGJeg-MUPl4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45111 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab0EYMuF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 08:50:05 -0400
In-Reply-To: <AANLkTimy4PLEJ7LtnO79nF_NbMUrpIvfhfGJeg-MUPl4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Robert Nelson <robertcnelson@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>

On Mon, 2010-05-24 at 19:02 +0200, ext Robert Nelson wrote:

> After 10mins, the display enters dpms mode (suspend) neither ssh or
> serial activity will resume the display. (not a bug, usb
> mouse/keyboard will of course awaken it..)
> 
> But when reboot is called, it doesn't handle the display correctly
> when it's suspended..  By simply un-suspending the display from
> suspend the bug goes away.. Not sure on the best method to detect this
> situation, but the attached quick patch seems to fix it on my beagles
> using generic_panel_disable...

Right, panel-generic tries to handle things a bit too simply.

Your patch first powers on the display if it's suspended at disable
time. This is not necessary.

Also, mutexes should be added to all the functions that are called from
outside.

panel-taal.c tries to do these a bit better. I guess the locking and
handling the dssdev->state could be copied quite directly from there. 

I'm overloaded with work currently, so I can't make any promises when
I'll get to do it, but patches are always accepted! =)

 Tomi


