From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] [PATCH 0/2] High Speed uart support on 3430
Date: Mon, 17 Dec 2007 09:36:58 -0800
Message-ID: <20071217173658.GF7388@atomide.com>
References: <02a301c840b7$ccdcbbb0$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <02a301c840b7$ccdcbbb0$988818ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Girish <girishsg@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Girish <girishsg@ti.com> [071217 06:19]:
> Hi,
> This patch series adds high speed uart support on 3430.=20
>=20
> UART library Interfaces:
> The UART library interfaces the user drivers with UART hardware and exp=
orts API=92s to configure UART for different types of
> applications such as High speed(HS) UART, IrDA and Bluetooth etc.=20
> The most of the API=92s exported by UART library are functionality base=
d API=92s which are used by client drivers for different purposes
> such as=20
> -	Requesting UART
> -	Initial UART configuration
> -	Data transfer Configuration(DMA mode)
> -	ISR registration
> -	UART Speed change

Well all that sounds good, but please move the driver to drivers/serial
to start with.

Regards,

Tony
