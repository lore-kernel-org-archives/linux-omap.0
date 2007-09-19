From: <Tuukka.Tikkanen@elektrobit.com>
Subject: RE: Problem in omap_pm_idle()
Date: Wed, 19 Sep 2007 15:58:11 +0300
Message-ID: <3E32F84CD6CB95498A35B353CA3B930C067318@fioues08.ebgroup.elektrobit.com>
References: <46EFDF0D.8000808@celunite.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1190206842-3398-2"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <46EFDF0D.8000808@celunite.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: vivek.kutal@celunite.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1190206842-3398-2
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

From: Vivek Kutal
Subject: Problem in omap_pm_idle()
>=20
> Hi ,
>        I was looking at omap_pm_idle() in omap1/pm.c , at the end
there=20
> is a call to omap_sram_suspend , shouldn't it be omap_sram_idle() ?
>        and if CONFIG_OMAP_MPU_TIMER is set it sets  use_idlect1 =3D=20
> use_idlect1 & ~(1 << 9) ,  but it does not go into wait for interrupt.
>        Can anyone please explain this ?

The only real difference between suspend and idle sleep on omap1 is that
for suspend peripheral devices are forcibly shut down. Also the idle
sleep avoids turning off certain clock in some special cases. If there
is no user or application activity, when everything is working as
intended the hardware ends up into suspend-like state in idle sleep to
conserve battery (with very quick recovery however), so the call is
correct.

Tuukka


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


------------=_1190206842-3398-2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------------=_1190206842-3398-2--
