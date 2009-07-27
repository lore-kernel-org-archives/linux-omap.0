From: Gary Thomas <gary@mlbassoc.com>
Subject: OMAP camera with BT-656 sensor
Date: Mon, 27 Jul 2009 13:10:54 -0600
Message-ID: <4A6DFBBE.6020805@mlbassoc.com>
References: <a187869d0907270546m2be3542cla72366acfc62fb64@mail.gmail.com>	 <a187869d0907270725n7fce759bs6bcaeed70bd7f872@mail.gmail.com>	 <A24693684029E5489D1D202277BE89444A16EC65@dlee02.ent.ti.com>	 <a187869d0907270859l313b86d3nea833c7a019d35be@mail.gmail.com>	 <A24693684029E5489D1D202277BE89444A16ECD1@dlee02.ent.ti.com>	 <a187869d0907270911j74ee55b9nc872687eb32aecce@mail.gmail.com>	 <A24693684029E5489D1D202277BE89444A16ED18@dlee02.ent.ti.com>	 <a187869d0907271036meb56ce9r32c5f5e823465e87@mail.gmail.com>	 <A24693684029E5489D1D202277BE89444A16EE88@dlee02.ent.ti.com>	 <a187869d0907271145i177dcf52jb75aee758300878@mail.gmail.com> <a187869d0907271146q66112fc8l85aa37c8b1512d68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:1935 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbZG0TLA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 15:11:00 -0400
In-Reply-To: <a187869d0907271146q66112fc8l85aa37c8b1512d68@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: saaguirre@ti.com
Cc: linux-omap@vger.kernel.org

Sergio,

I'm trying to use your tree with a BT-656 style sensor(*).  I've
managed to get this [more or less] working when I use the official
TI PSP tree + OMAP3 patches, but I'm not getting very far with
your code.  I just updated my copy from your tree, but I don't
see any real changes since June 18 when I first started looking
at this.

I've made a number of changes, inspired by the PSP code to get
the BT-656 handling enabled in the CCDC.  I do see that the PSP
codebase seems older than yours? but is more complete in other
respects.  Can you enlighten me as to the heritage of these
different trees?

The problem I have at the moment is that sensor data is getting
into the CCDC module, but since the previewer/resizer modules
are not used, nothing is ever delivered to my user code.

Bottom line, I'm confused as to how I should go about getting
my driver/system working.  Do I use your work, or just stick
with the PSP base (why?)??

Thanks

(*) I cloned: git://dev.omapzoom.org/pub/scm/saaguirre/linux-omap-camera.git

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
