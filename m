From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC 00/15] Add basic suspend-resume support for AM33XX
Date: Sat, 3 Nov 2012 08:39:20 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFE615@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <50944655.20602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57166 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab2KCIjg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 04:39:36 -0400
In-Reply-To: <50944655.20602@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi Daniel,

On Sat, Nov 03, 2012 at 03:46:53, Daniel Mack wrote:
[...]
> 
> What event did you use to bring the system back to life? I tried a GPIO
> button which has "linux,wakeup" set and is connected to GPIO bank 0, but
> without success.

I used uart wakeup in my testing. I see that you have CPSW driver also
in your kernel. Can you try with a minimal set of drivers, similar to what
BeagleBone has on Tony's master branch right now.
 
Mugunthan mentioned he has a fix of the WARN_ON from CPSW driver that you
see in the logs and that will be posted shortly. Can you mention what other
patches you have pulled in?

Regards,
Vaibhav
