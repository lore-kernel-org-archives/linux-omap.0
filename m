From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 2/7
Date: Tue, 21 Feb 2006 10:06:12 -0400
Message-ID: <9268368b0602210606y5a84b111g459f2b293d4ece4@mail.gmail.com>
References: <9268368b0602200947g57ed39d6y28d4612ed4278cda@mail.gmail.com>
	<520AB2AD990DC04082102F77CA1726381036EB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA1726381036EB@dlee03.ent.ti.com>
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
To: "Menon, Nishanth" <x0nishan@ti.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

HI Nishanth,

Thanks for the comments.

On 2/21/06, Menon, Nishanth <x0nishan@ti.com> wrote:
>
>
> Nope, does not look a good idea to me, as we will not be able to pull the=
se
> out for 2420/2430 platforms(unless we move it to plat). why keep the
> tsc2101/aic in platforms specific directory if:
> 1. it can have varied control path
> 2. data transfer paths?
> 3. defined set of apis which can be called  by an higher abstraction laye=
r?

Indeed. We already make up our mind. These files will leave this directory =
:-) .

> I can see the transfer configuration is mainly setup from board file, whi=
ch
> is an excellent idea. however for codecs.. err.. sound/... is a nice plac=
e
> for it to remain..

You mean the codec files moving to sound/ ? With this board file
approach this cause problems in linking the codec functions in the
board file. They had to stay in the omap tree not in the sound/ .
Maybe a better place to them could be plat-omap/ ?

> This will allow:
> 1. Other platforms other than omap also to be able to use tsc2101
> functionalilty
> 2. have common support for alsa and oss - i dont see oss dying a lot soon=
er
> ;)
> why would we want to stop the cross leverage?

Anyway, with this approach they can be used in other architectures as
well with small modifications. And in omap oss too.

> Regards,
> Nishanth Menon

Regards,
Daniel
--
INdT - Manaus - Brazil
