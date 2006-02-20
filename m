From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 0/7
Date: Mon, 20 Feb 2006 16:35:51 -0400
Message-ID: <9268368b0602201235l185c47e7x5ee72dca146dbadb@mail.gmail.com>
References: <9268368b0602200933s41905c2bp254749b1e6eff9c7@mail.gmail.com>
	<20060220203304.1793.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060220203304.1793.qmail@web32901.mail.mud.yahoo.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 2/20/06, Komal Shah <komal_shah802003@yahoo.com> wrote:
> --- Daniel Petrini <d.pensator@gmail.com> wrote:
>
> >
> > 2) If it is acceptable to put the codecs under arch directory, would
> > plat-omap be better location than arch-omap1, for mcbsp supported
> > codecs? (Are there any omap2 boards with aic23 or tsc2101 codecs?)
>
> Yes my custom board (Tsunami) based on OMAP2 has AIC23 and H4 TI EVM is
> having tsc2101 audio codec chip.

And BTW, are these codecs connected to McBSP or other serial peripheral?

> ---Komal Shah
> http://komalshah.blogspot.com/
>

Daniel

--
INdT - Manaus - Brazil
