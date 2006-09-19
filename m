From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Fwd: Problems loading ffs image
Date: Mon, 18 Sep 2006 20:08:00 -0500
Message-ID: <450F42F0.6060108@gmail.com>
References: <ae36f8040609151022l1239fc8ft91e96ad26e7db4ed@mail.gmail.com>	<ae36f8040609181359u40b0862cyfd380e33192d1a6d@mail.gmail.com>
	<ae36f8040609181400h1b1ef261v3c25fc5630351392@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040609181400h1b1ef261v3c25fc5630351392@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?= <lvcargnini@ieee.org>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Lu=EDs Vit=F3rio Cargnini stated on 9/18/2006 4:00 PM:
> hi,
> I'm working one the problem i fixed the init problem, remove init suppo=
rt
> from busybox and cross compiled the coreutils and sysvinit to my plataf=
orm,
> besides i still having the following problem:
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
> 0x2cac instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000004:
> 0x4b8b instead
This looks like a bad filesystem. Maybe ur not using an kernel without a
compatible mtd-utils. MTD had moved to EBH and broken Cleanmarkers
sometime back. there was a discussion to make utils backward
compatible.. R u using the latest kernel?
Regards,
Nishanth Menon
