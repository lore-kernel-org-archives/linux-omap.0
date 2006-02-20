From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: [PATCH] Alsa modularisations and support for tsc2101 0/7
Date: Mon, 20 Feb 2006 17:20:50 -0400
Message-ID: <9268368b0602201320h7bd1d794m2a30cb6363d62322@mail.gmail.com>
References: <9268368b0602201235l185c47e7x5ee72dca146dbadb@mail.gmail.com>
	<20060220205807.86025.qmail@web32906.mail.mud.yahoo.com>
	<9268368b0602201316q4533a165p75a4bd0ab489681d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602201316q4533a165p75a4bd0ab489681d@mail.gmail.com>
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Ops, copying to list.

---------- Forwarded message ----------
From: Daniel Petrini <d.pensator@gmail.com>
Date: Feb 20, 2006 5:16 PM
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 0/7
To: Komal Shah <komal_shah802003@yahoo.com>

Humm,

On 2/20/06, Komal Shah <komal_shah802003@yahoo.com> wrote:
> --- Daniel Petrini <d.pensator@gmail.com> wrote:
>
> >
> > And BTW, are these codecs connected to McBSP or other serial
> > peripheral?
>
> Yes it is connected to McBSP. McBSP1 in Tsunami board and McBSP2 in
> case of H4. (So more #ifders to select AUDIO_MCBSP :) ).

That is actually good news. This means that with this proposed
modularisation, alsa can easily work in these platforms, unless the
2420 dma for audio be quite different.
Regarding the #ifdefs, one can always (carefully) insert a field in
the new omap_alsa_codec_config and pass the architecture difference in
the board* files.

Cheers,

Daniel
--
INdT - Manaus - Brazil


--
INdT - Manaus - Brazil
