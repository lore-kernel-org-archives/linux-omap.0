From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v6 1/1] OMAP2: Spi: Force CS to be in inactive state after
 off-mode transition
Date: Wed, 29 Dec 2010 12:07:08 +0100
Message-ID: <4D1B165C.3020008@free-electrons.com>
References: <4D149045.8080801@free-electrons.com> <20101229072800.GF8172@angua.secretlab.ca> <4D1AF8D7.6060904@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:49846 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab0L2LHX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Dec 2010 06:07:23 -0500
In-Reply-To: <4D1AF8D7.6060904@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, David Brownell <dbrownell@users.sourceforge.net>, Kevin Hilman <khilman@deeprootsystems.com>

On 12/29/2010 10:01 AM, Gregory CLEMENT wrote:
>> Hi Gregory,
>>
> Hi Grant,
> 
>> Patch does not apply, but I cannot immediately isolate the damage.
>> Please see if you can figure out the issue on your end.  Is it your
>> mailer?  I could fudge it, but in the long run it is better if this
>> issue can get sorted out now.
>>
> 
> I found the problem: see below in the patch itself.
> 
Indeed it was may mailer which had broken the patch. I use
git-format-patch and git imap send to create the mail. But when I
open it from the draft folder to add the email address, it decides
by itself to remove an end of line!
It is not the first time that I have some problems with Thunderbird.
I consider changing my mailer to a more "hacker friendly" one.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
