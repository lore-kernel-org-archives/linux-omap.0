From: <Tuukka.Tikkanen@elektrobit.com>
Subject: RE: Why does it increase the dsor value in MMC?
Date: Fri, 29 Jun 2007 17:15:39 +0300
Message-ID: <3E32F84CD6CB95498A35B353CA3B930C0672DD@fioues08.ebgroup.elektrobit.com>
References: <001401c7ba33$31339130$e1ac580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1183126539-12348-10"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <001401c7ba33$31339130$e1ac580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1183126539-12348-10
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I wrote the original code (and it did not have 2 increments), but the
second increment has appeared later on. I suspect might be duplicate
from the if statement caused by some merge conflict resolution. I do not
have OMAP TRM any longer, so I cannot check whether for example the
hardware register value has some funny offset (or if value 251 would be
illegal, for that matter.)

Another strong possibility is that whoever has been modifying the code
had a MMC card that reported higher speeds that it was actually able to
handle and adding the final increment "magically" fixed his/her
problems.

Removing the line improves performance for most people, but might break
some hardware combinations (the above case). If you can verify from TRM
that the value written to register is the actual divisor (and not like
1=3D0, 2=3D1 etc), I'm all for removing the last line, since its
undocumented and causing confusion. Unless, of course, someone can come
up with a reason for it and it gets documented.

Tuukka


-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Kyungmin Park
Sent: 29 June 2007 12:52
To: 'Linux OMAP'
Subject: Why does it increase the dsor value in MMC?

Hi,

In mmc_omap_calc_divisor(). We calculate the dsor value.
In the code why does it increase the dsor at the end of code?

Now the Apollon board uses func_clk_rate as 95,000,000 and ios->clock is
20,000,000

	dsor =3D func_clk_rate / ios->clock;	=3D> 4
        if (dsor < 1)
                dsor =3D 1;

        if (func_clk_rate / dsor > ios->clock)	=3D> True
                dsor++;				=3D> 5

        if (dsor > 250)
                dsor =3D 250;
        dsor++;					=3D> 6

After the current calculation, we use the host clock as 15,833,333 (dsor
6). But
if it is not increased, we can use the 19,000,000 (dsor 5)

It there any reason to increase this value?

Thank you,
Kyungmin Park

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


------------=_1183126539-12348-10
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------------=_1183126539-12348-10--
