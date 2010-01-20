From: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Subject: RE: [PATCHV2 2/2] OMAP3630: Clock: Fixing HSDivider Limitation
Date: Wed, 20 Jan 2010 11:31:43 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DC4BE@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.1001192244070.3977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59961 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab0ATGCN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 01:02:13 -0500
In-Reply-To: <alpine.DEB.2.00.1001192244070.3977@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Turquette, Mike" <mturquette@ti.com>, "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

:) Thanks..

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, January 20, 2010 11:15 AM
> To: G.N, Vijayakumar
> Cc: Turquette, Mike; Kauppi Ari (EXT-Ixonos/Oulu); linux-omap@vger.kernel.org;
> khilman@deeprootsystems.com; Sripathy, Vishwanath
> Subject: RE: [PATCHV2 2/2] OMAP3630: Clock: Fixing HSDivider Limitation
> 
> Hello Vijayakumar,
> 
> On Wed, 20 Jan 2010, G.N, Vijayakumar wrote:
> 
> > This seems to better than which currently I have; I will incorporate and
> > test it for the same.  I will add few more comments to have a better
> > clarity in the same function.
> 
> That's fine but please keep in mind this section from CodingStyle:
> 
> --------
> 
> Generally, you want your comments to tell WHAT your code does, not HOW.
> Also, try to avoid putting comments inside a function body: if the
> function is so complex that you need to separately comment parts of it,
> you should probably go back to chapter 6 for a while.  You can make
> small comments to note or warn about something particularly clever (or
> ugly), but try to avoid excess.  Instead, put the comments at the head
> of the function, telling people what it does, and possibly WHY it does
> it.
> 
> --------
> 
> - Paul
