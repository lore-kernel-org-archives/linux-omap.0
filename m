From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH-V4 0/3] Introducing TI's New SoC/board AM335XEVM
Date: Fri, 2 Dec 2011 04:36:02 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A902847B@DBDE01.ent.ti.com>
References: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
	<878vmxxjrv.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A80474FD@DBDE01.ent.ti.com>
 <878vmws4z8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58290 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333Ab1LBEgY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 23:36:24 -0500
In-Reply-To: <878vmws4z8.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>

Hi Kevin,

On Thu, Dec 01, 2011 at 20:40:03, Hilman, Kevin wrote:
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
:
> > We can detect the board using on-board EEPROM, so same mach-id
> > should work for both EVM and Beagle. 
> 
> > And also going forward with device tree approach we may
> > not need different id's, right?
> 
> Right, which is why I'm wondering why are there sevral new AM33x
> mach-types when only one of them is being used:
> 
> 3684    TI AM335X IA EVM        am335xiaevm     Afzal Mohammed
> 3589    TI AM335X EVM           am335xevm       Vaibhav Bedia
> 3808    Beaglebone Board        beaglebone      Steven Kipisz
> 
> Russell has been trying to cleanup athe mach-types, so if these others
> are not going to be used, I suggest they be deleted.

"3684-TI AM335X IA EVM" is required as IA EVM uses a different UART,
because of which early prints can't be captured, problem mentioned
in http://marc.info/?l=linux-omap&m=131286938723617&w=2


Note: Paul advised to post to linux-arm-kernel@lists.infradead.org,
but it never made to LAKML, even though I sent couple of times and got
a reply "Is being held until the list moderator can review it for
approval. The reason it is being held: Message has a suspicious header"

Regards
Afzal

