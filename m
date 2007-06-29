From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: PRCM_CONFIG_5A
Date: Fri, 29 Jun 2007 09:33:30 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47013BF56E@dlee13.ent.ti.com>
References: <c656a4d20706290651h6a841690j480df1af9b61476c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20706290651h6a841690j480df1af9b61476c@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: arun c <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Arun,

>with both the following settings in uboot my board is working fine.
>
It should work, if it doesn't then it is a problem :)

>#define PRCM_CONFIG_5A           1    /* 2430 ES1 */
>//#define PRCM_CONFIG_2         1 /* 2430 ES2+330ARM+DDR-165-PISMO */
>
>Is that board supposed to work with  PRCM_CONFIG_2 settings in uboot?
>
Board can boot / work in both 5A and 2 Configuration.=20

>Same hardware different clock settings i wonder how its happening.
>please somebody help me
5A configures the Core clock to operate at 165Mhz and 2 makes it operate =
at 330 Mhz.

Let me know if you need more info.

Regards,
Khasim
