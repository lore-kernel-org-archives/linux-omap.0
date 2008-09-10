From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Working with Linux-Omap GIT Tree
Date: Tue, 9 Sep 2008 19:58:29 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203655BDCDA@dlee02.ent.ti.com>
References: <1f11a5490809041150y69023b30ub166cc34615744b5@mail.gmail.com>
	 <A24693684029E5489D1D202277BE894411A86A45@dlee02.ent.ti.com>
 <1f11a5490809091152j767d9032jecdeeace5b2d40bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49516 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbYIJA6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 20:58:38 -0400
In-Reply-To: <1f11a5490809091152j767d9032jecdeeace5b2d40bb@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Ashwin Bihari

> A quick question about the OMAP GIT trees as I'm playing with them
> right now. There are two trees that I can see, one at
> http://git.omapzoom.org/repo/omapkernel and another at
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git.
> The OMAPZoom tree seems to have a few of the files that are missing
> from the git.kernel.org tree that I was looking to modify..
>
> Which tree should I be using to put my board-support files into? Or is
> it a combination of the two?

Trees are related. Base line is derived by taking kernel.org, then linux-omap, then zoom specifics. The ultimate goal is functionality kernel.org.

The zoom kernel synchronizes with linx-omap frequently. It is different in a few areas. Part of its purpose is to export functionality as soon as possible. Traditionally, early chip development hasn't been available externally. This results in a divergence gap at the time of chip release.  We export the tree as a way to provide access to that work. It will take some time for public flows to pick up functionality. Making this reference available should accelerate new functions back into pure open source.

How you leverage the tree depends on your needs.

A differences list can be found: https://omapzoom.org/gf/project/omapkernel/wiki/?pagename=areas

Regards,
Richard W.

