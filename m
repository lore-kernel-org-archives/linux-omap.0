From: Tony Lindgren <tony@atomide.com>
Subject: Re: Re: Help me. Oops: 805 [#1]err using kernel.2.6.10.omap1patch
	with NFS(RFS)
Date: Thu, 19 Jan 2006 17:10:00 -0800
Message-ID: <20060120011000.GV4425@atomide.com>
References: <43D03607.000001.29461@naver892>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43D03607.000001.29461@naver892>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: =?utf-8?B?IuyehOq3vOyLnSI=?= <invain@naver.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* "=EC=9E=84=EA=B7=BC=EC=8B=9D" <invain@naver.com> [060119 17:07]:
>=20
> Thank you for offering you patch file. But, I tried thus patch work alr=
eady for solve this problem.
> In the long run , Although I adjusted patch to smc91x.c file, booting s=
till is failed with nfs RFS.
> I am poor knowledge about device dirver. If possible, I need technique =
of veteran engineer.
>=20
> P.S: When i send packet using nmap tool from host(192.168.0.2) to targe=
t(192.168.0.10) ,
> Below message appeared on minicom console.
> -------------------------------------------------------
> eth0: bad memory timings: rxlen 0 status 507f
> eth0: bad memory timings: rxlen 0 status 407f
> -------------------------------------------------------

See what board-osk.c does for EMIFS:

static void __init osk_init_smc91x(void)
{
        if ((omap_request_gpio(0)) < 0) {
                printk("Error requesting gpio 0 for smc91x irq\n");
                return;
        }

        /* Check EMIFS wait states to fix errors with SMC_GET_PKT_HDR */
        EMIFS_CCS(1) |=3D 0x3;
}

Regards,

Tony
