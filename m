From: "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>
Subject: Re: [PATCH 3/5] OV3640: Add driver
Date: Tue, 10 Mar 2009 09:29:49 +0200
Message-ID: <200903100929.50049.tuukka.o.toivonen@nokia.com>
References: <1236212613.8608.19.camel@tux.localhost> <A24693684029E5489D1D202277BE89442E40F7EF@dlee02.ent.ti.com> <7A436F7769CA33409C6B44B358BFFF0CFF3E86F7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27540 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbZCJHaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 03:30:03 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF3E86F7@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Menon, Nishanth" <nm@ti.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Alexey Klimov <klimov.linux@gmail.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>, MiaoStanley <stanleymiao@hotmail.com>, "Nagalla, Hari" <hnagalla@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Lakhani, Amish" <amish@ti.com>

On Monday 09 March 2009 23:29:27 ext Menon, Nishanth wrote:
> Further, we have multiple sensors following CCI[1] - why not have a driver
> for the same, it will simplify the entire process - ov3640, mt9p012 both
> follow the spec at least.. dependency would be sensor -> cci dev->i2c
> framework.   

Sakari has written smiaregs.c pretty much exactly for this
purpose. You should check it out.

- Tuukka
