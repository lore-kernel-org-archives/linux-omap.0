From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2] AM35xx: Clock table updates for AM3505/17
Date: Mon, 14 Dec 2009 13:11:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912141307330.12561@utopia.booyaka.com>
References: <1258437308-29289-1-git-send-email-ranjithl@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BC14218A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36652 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758196AbZLNULr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 15:11:47 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC14218A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lohithakshan, Ranjith" <ranjithl@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, vishwanath.bs@ti.com, "tony@atomide.com" <tony@atomide.com>

Hi Ranjith,

I regret the delay -

On Mon, 14 Dec 2009, Lohithakshan, Ranjith wrote:

> Where does this patch stand in your queue? If there are no further comments,
> can this one be taken up on for-next?

I've updated this patch for the new .33 clock file layout.  The job needed 
to be done by hand, and I don't have a Sitara board, so, could you test 
the updated patches out?  If they work okay for you, and are aligned with 
what Vishwanath needs for 36xx, then I will queue them for the .34 merge 
window.


- Paul
