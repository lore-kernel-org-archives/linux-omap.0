From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 09/15] ARM: OMAP: AM33XX: Remove unnecessary include and
 use __ASSEMBLER__ macros
Date: Sun, 4 Nov 2012 15:26:19 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFFD3C@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-10-git-send-email-vaibhav.bedia@ti.com>
 <50954683.4050302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43176 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356Ab2KDP0Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Nov 2012 10:26:24 -0500
In-Reply-To: <50954683.4050302@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Sat, Nov 03, 2012 at 21:59:55, Shilimkar, Santosh wrote:
> On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> > Get rid of some unnecessary header file inclusions
> > and also use __ASSEMBLER__ macros to allow the
> > various register offsets from PM assembly code
> > which be added in a subsequent patch.
> >
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> Ideally you should split header clean-up and assembler
> fix in seperate patches.
> 

Ok. Will do.

Regards,
Vaibhav
