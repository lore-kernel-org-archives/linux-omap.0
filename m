From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [DSPBRIGDE PATCH 6/6] dsp: bridge: beautify erro path
Date: Tue, 1 Sep 2009 00:54:01 +0300
Message-ID: <20090831215401.GA30847@nokia.com>
References: <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-5-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-6-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-7-git-send-email-felipe.balbi@nokia.com>
 <496565EC904933469F292DDA3F1663E602A5EF29FB@dlee06.ent.ti.com>
 <5ec8ebd50908281413j139f01a8q25c9e9c4339e5a25@mail.gmail.com>
 <496565EC904933469F292DDA3F1663E602A5EF2A6D@dlee06.ent.ti.com>
 <5ec8ebd50908290018r670b6480pe311bb0812587d3b@mail.gmail.com>
 <496565EC904933469F292DDA3F1663E602A5EF2E1F@dlee06.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58216 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbZHaVyf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 17:54:35 -0400
Content-Disposition: inline
In-Reply-To: <496565EC904933469F292DDA3F1663E602A5EF2E1F@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Mon, Aug 31, 2009 at 09:50:30PM +0200, ext Guzman Lugo, Fernando wrote:
> >As far as I see this is not the dsp status but just a word to collect
> >errors. More logical in this piece of your code is to use result word
> >instead of status.
> 
> Maybe you did not see far enough, but variable initStatus it the one use to
> store DSPBridge errors, the variable status is use to collect the status
> from calls to kernel functions. So I think we don't need two variables to
> collect error from kernel, so we should use one, it could be status or
> results it does not matters. What do you think?

yes, this has to be cleaned up, but it should be an extra patch and not
in this one.

-- 
balbi
