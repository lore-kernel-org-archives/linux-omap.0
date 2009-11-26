From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/9] DSPBRIDGE: trivial checkpatch fixes
Date: Thu, 26 Nov 2009 09:30:48 +0200 (EET)
Message-ID: <20091126.093048.71097588.Hiroshi.DOYU@nokia.com>
References: <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
	<1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
	<4B0DA394.2030705@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64749 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758746AbZKZHat (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 02:30:49 -0500
In-Reply-To: <4B0DA394.2030705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: linux-omap@vger.kernel.org, dedekind1@gmail.com, nm@ti.com

Hi Omar,

From: ext Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/9] DSPBRIDGE: trivial checkpatch fixes
Date: Wed, 25 Nov 2009 22:37:24 +0100

> Ramirez Luna, Omar had written, on 11/23/2009 06:50 PM, the following:
> > Quick fixes like:
> General comment: please do white space changes as a separate patch. this
> massive patch is pretty difficult to review otherwise.. might have been
> as simple as doing scripts/Lindent on all files and refixing with
> scripts/checkpatch.pl ..

In addition to the above two scripts,

- make C=1 for sparse
- scripts/cleanpatch
- scripts/cleanfile
or
- "whitespace-cleanup" in emacs

Automatic checkings with the those scripts may be useful too.
They could save most of trivial coding style discussions here.
