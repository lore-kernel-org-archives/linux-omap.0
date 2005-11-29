From: Louis Jung <lhsj81@gmail.com>
Subject: Re: DSP core access
Date: Wed, 30 Nov 2005 10:30:23 +1100
Message-ID: <cb6819fd0511291530t43035085tb84c26675a9e6e1f@mail.gmail.com>
References: <C51F43ABFC95844490F0529B60753BF402AF9F99@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <C51F43ABFC95844490F0529B60753BF402AF9F99@dlee02.ent.ti.com>
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
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Toshihiro.Kobayashi@nokia.com, linux-omap-open-source@linux.omap.com, comunerito@yahoo.com
List-Id: linux-omap@vger.kernel.org

Thanks heaps again.

Currently I am not using montavista linux, as some of the bash scripts in
the Linux-DSP-tools have already been configured to, So I guess I will
figure out what I need to change and then proceed from there on,

Again, thank you very much,
Cheers


On 11/30/05, Hunter, Jon <jon-hunter@ti.com> wrote:
>
> >
> > Yes it is.
> > 5910, 5912, 1510, 161x and 1710 has the same architecture
> > from DSP point of view, except for the clock speed.
> >
>
> Please note that the C55x DSP core revision may differ between devices.
> For example, the OMAP5910 has a C55x v2.1 core and the OMAP5912 has a
> v2.2 core. The C55x C compiler has a "-v" option that allows you to
> specify the version of C55x core your device has. If you see the
> rules.mak file for the reference frameworks you may see the "-v" option
> specified as "-v5510:2". This indicates a v2.2 core for the OMAP5912.
> What I would recommend is that for the OMAP5910 you use "-vcore:2.1" and
> for the OMAP5912 you use "-vcore:2.2" (although this is the same as
> -v5510:2). Otherwise you may use the compiler for the above devices.
>
> Regards,
> Jon
>
