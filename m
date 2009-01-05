From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: git clone through http not working well
Date: Mon, 5 Jan 2009 14:23:09 -0600
Message-ID: <7B4574D56E4ADF438756313E9A172A871FCB5465@dlee01.ent.ti.com>
References: <A24693684029E5489D1D202277BE89441623BAEF@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40085 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546AbZAEUXT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2009 15:23:19 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n05KND6J004884
	for <linux-omap@vger.kernel.org>; Mon, 5 Jan 2009 14:23:18 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n05KNAED007780
	for <linux-omap@vger.kernel.org>; Mon, 5 Jan 2009 14:23:10 -0600 (CST)
In-Reply-To: <A24693684029E5489D1D202277BE89441623BAEF@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Sergio,

> I was trying to clone the git tree using http protocol,
> because git protocol is blocked by my network firewall, and I
> got this after a while:


I have not seen this issue, but I have been using corkscrew so that I can use the git protocol behind a firewall. For more details on using corkscrew see:

http://wiki.omap.com/index.php?title=Git#Using_Git_Behind_a_Firewall

Cheers
Jon
