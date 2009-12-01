From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: linux-2.6.28-rc6-omap1
Date: Tue, 1 Dec 2009 17:17:40 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ABC1DDB@dbde02.ent.ti.com>
References: <48239d390912010235r33da0875s45cf4426e05dd021@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56326 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785AbZLALrj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 06:47:39 -0500
In-Reply-To: <48239d390912010235r33da0875s45cf4426e05dd021@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergey Lapin <slapinid@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Hi, all!
> 
> Is there some git repository with kernel version 2.6.28-rc6-omap1?
> As I understand it is older OMAP3 kernel Nokia n900 and 
> Beagle were based on.
> I just need it as merge base to move some work, based on
> 2.6.28-rc6-omap1 to mainline
> in maintainable way, so I need it to have proper history. Any links?
> 

v2.6.28-omap1 exists as a tag on Tony's linux-omap tree [1].

You can just clone that and checkout that tag. Or browse the
gitweb at [2].

- Anand

[1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
[2] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=tree;h=refs/tags/v2.6.28-omap1
