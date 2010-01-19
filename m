From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] Introduce clock support for AM35xx IPSS modules
Date: Tue, 19 Jan 2010 12:41:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001191232250.3977@utopia.booyaka.com>
References: <1263892796-2279-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38116 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881Ab0ASTl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 14:41:59 -0500
In-Reply-To: <1263892796-2279-1-git-send-email-ranjithl@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Ranjith,

On Tue, 19 Jan 2010, Ranjith Lohithakshan wrote:

> The patch series add support for the new modules on AM35xx IP Sub-System
> (IPSS) and incorporates all the earlier review comments.
> 
> Since AM35xx follows a completely different scheme for indicating clock
> idle status, the find_idlest() function in clkops is extended to pass
> back the idle status indicator for that clock.
> 
> This patch series depends on the following patches
> http://marc.info/?l=linux-omap&m=126325725822266&w=2
> http://marc.info/?l=linux-omap&m=126325725822263&w=2
> http://marc.info/?l=linux-omap&m=126325725722251&w=2
> 
> Tested on OMAP3 and AM3517 EVM's.
> 
> Ranjith Lohithakshan (2):
>   OMAP2/3 clock: Extend find_idlest() to pass back idle state value
>   AM35xx: Add clock support for new modules on AM35xx

Thanks, this series looks almost perfect except for a few minor issues, 
will comment on those on the patches themselves.

Some of the things that you did in this series which I really appreciate:

1. You posted the list of patches which your series depends on (in the 
above E-mail)

2. You posted the platforms that you tested your patch on (also in the 
above E-mail)

3. You put kerneldoc documentation into your code

4. You fixed a problem with the existing documentation

5. During the patch comment process, you helped me understand what is
going on with the chip

Now there are three general areas that could use some improvement:

1. One of the patches has a problem that would be caught by checkpatch.pl 
(comments following).  Please run this on all your patches prior to 
submission.

2. There are some whitespace problems with some of your struct definitions
(comments following).  I'm not sure what editor you use, but consider
using an editor that colors tabs differently than spaces.  For example, 
emacs' show-wspace.el script

3. One of the patches introduces a sparse warning.  Please run 'make C=2 
objectfilename.o' on all files that your patches touch and make sure you
don't add any new sparse warnings.  Bonus points for removing existing 
sparse warnings :-)  (comments following)



- Paul
