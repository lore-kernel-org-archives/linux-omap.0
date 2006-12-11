From: tony@atomide.com
Subject: Re: [patch 2.6.19] omap camera builds again; Mistral hooks
Date: Mon, 11 Dec 2006 14:21:35 -0800
Message-ID: <20061211222134.GG31722@atomide.com>
References: <20061207034509.5BC701E771D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200612070558.19023.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200612070558.19023.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Marek Va=C5=A1ut <marek.vasut@gmail.com> [061206 20:59]:
> Hi, just a small typo ...
> static char banner[] __initdata =3D KERN_INFO "OMAP Camera driver=20
> initialzing\n"; ... should be initializing ;-)

Pushed in two parts, one for the core changes, and the other patch
for the driver. I had to manually apply some parts of the driver
patch. Dave, can you please check that your changes got applied?

Tony
