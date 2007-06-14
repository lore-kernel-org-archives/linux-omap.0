From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 5 / 12] Board 3430 SDP file
Date: Thu, 14 Jun 2007 14:23:28 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47011E64A2@dlee13.ent.ti.com>
References: <001901c7ae50$23ba5820$e1ac580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <001901c7ae50$23ba5820$e1ac580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kmpark@infradead.org, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Kyungmin,

>> +};
>> +
>
>To disable the wire4 mode, you should assign the value 0 instead of -1. =
The
>"-1"
>will enable the wire4 mode in the code.
>
Thanks for pointing this out. I will take this up along with MMC driver =
for 2430 / 3430.

For now, I prefer continuing with same patch.

I will be shortly adding OneNAND and Keypad drivers for 3430. Will work =
on MMC along with these.

Regards,
Khasim=20
