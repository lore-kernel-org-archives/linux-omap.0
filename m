From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 20 May 2010 13:15:34 +0300
Message-ID: <20100520101534.GH9992@nokia.com>
References: <1274124267.4418.149.camel@mulgrave.site>
 <20100517193840.GB14047@gandalf>
 <20100517193952.GC14047@gandalf>
 <1274125775.4418.182.camel@mulgrave.site>
 <20100518064022.GA6522@nokia.com>
 <1274191188.10304.5.camel@mulgrave.site>
 <20100519065934.GH12879@nokia.com>
 <20100520071528.494c38e4@schatten.dmk.lab>
 <20100520085739.GB14584@gandalf>
 <20100520120519.0d27d6bf@schatten.dmk.lab>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41353 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab0ETKU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 06:20:26 -0400
Content-Disposition: inline
In-Reply-To: <20100520120519.0d27d6bf@schatten.dmk.lab>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Florian Mickler <florian@mickler.org>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, ext James Bottomley <James.Bottomley@suse.de>, Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi,

On Thu, May 20, 2010 at 12:05:19PM +0200, ext Florian Mickler wrote:
>You said that already. For me this sounds like you want to take the
>users hostage in order to get nice (poweraware) apps.

not the users, no. The app developers. They should know what bad 
applications can cause to a nicely done system.

>Robust system design can take crap and perform well. Users will most of
>the time prefer a robust system over a nicely designed system. (Just
>think of the ak-47)

(hope you're talking about the gun :-p)
put some bad bullets on ak-47 and see if it behaves well, a really 
crappy trigger will also make it fail. How robust can a system be with 
badly chosen components ?

>I think we just have to agree to disagree here?

I think so.

-- 
balbi

DefectiveByDesign.org
