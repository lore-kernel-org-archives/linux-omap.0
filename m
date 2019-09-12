From: Adam Ford <aford173@gmail.com>
Subject: Re: [Letux-kernel] [RFC PATCH 0/3] Enable 1GHz support on omap36xx
Date: Thu, 12 Sep 2019 13:52:06 -0500
Message-ID: <CAHCN7xK=4JusZ-6r0qe0SBBb0KzVBguXWtw236kO5UQ4F=Jsig@mail.gmail.com>
References: <C04F49BA-1229-4E96-9FCF-4FC662D1DB11@goldelico.com>
 <CAHCN7x+Ye6sB_YqO0sAX1OJDw64B-qGS3pL545v3Xk5z914cwQ@mail.gmail.com>
 <0C1EF64E-B33C-4BFA-A7D3-471DD1B9EE86@goldelico.com> <515048DE-138D-4400-8168-F2B7D61F1005@goldelico.com>
 <CAHCN7xLPCX9rZ0+7KVBiA_bgZ6tg6VeCXqD-UXu+6iwpFMPVrA@mail.gmail.com>
 <7B3D1D77-3E8C-444F-90B9-6DF2641178B8@goldelico.com> <CAHCN7xLW58ggx3CpVL=HdCVHWo6D-MCTB91A_9rtSRoZQ+xJuQ@mail.gmail.com>
 <FA2920FE-B76A-4D44-A264-862A1CCBF7FC@goldelico.com> <CAHCN7xJsPa0i+Z+qpCkWcdAh9+udmGT0RPNchdDsfB=8ptd3Nw@mail.gmail.com>
 <87420DBD-770F-4C32-9499-A3AEA5876E8A@goldelico.com> <20190909163236.GP52127@atomide.com>
 <E001F74D-724E-4C50-9265-CBD33C4F2918@goldelico.com> <F8F08882-8011-441C-9581-ECCE9772EC21@goldelico.com>
 <CAHCN7x+fgtMHMNYU2W7BRQwd-d2g_Tb8-L5QNcnZjCF=VzRXJg@mail.gmail.com>
 <3663B13C-1AAB-4BE3-8CAD-F821B70393FA@goldelico.com> <CAHCN7x+mLCNq4evwGZfk6Ka=3o6EzhL=s38aNdukyLwKB1xO7A@mail.gmail.com>
 <56482888-DBD3-4658-8DB9-FB57653B5AA8@goldelico.com> <CAHCN7xLPZisrNk==eF-+V8hD+sceQq25qw+sK7vVZAYdd8=Q2Q@mail.gmail.com>
 <CAHCN7xL59cXgbe1YTbNvTjptO9bMnuxprCP7ok5kRuc8UO9Fcw@mail.gmail.com>
 <D7B54A39-D8A3-4EDF-8B47-66D59319B3F4@goldelico.com> <F65E947E-784A-4540-B926-BF3ECB0C01EC@goldelico.com>
 <285FED38-2B2B-4813-9FD2-396C53E9B1B2@goldelico.com> <CAHCN7xKyTnNojwRqsXcE1AsDKtJikBpXoUo8ED=89ZR9-ko9hA@mail.gmail.com>
 <65A23326-70B4-46E3-992D-74256B056900@goldelico.com> <CAHCN7xLGx0S3xyd0q-N8pgY8VdBbUUaJdgoxkKxakR59sH+zXQ@mail.gmail.com>
 <BF829797-492C-4120-AC69-F8B83572FD38@goldelico.com> <D3E8B5DC-AB53-4F46-8ABB-F839A11EB31C@goldelico.com>
 <CAHCN7xKq1CszKxax+7sG4O_V+iBYLSDVtDC480gvGV+KVb2-sw@mail.gmail.com> <CAHCN7xJgOhCpsiSvxOHeRz+621+t53pyt4_iE1PNCigznb1GLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xJgOhCpsiSvxOHeRz+621+t53pyt4_iE1PNCigznb1GLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Nishanth Menon <nm@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 12, 2019 at 8:58 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Sep 11, 2019 at 12:49 PM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Wed, Sep 11, 2019 at 12:43 PM H. Nikolaus Schaller <hns@goldelico.co=
m> wrote:
> > >
> > > Hi Adam,
> > >
> > > > Am 11.09.2019 um 18:01 schrieb H. Nikolaus Schaller <hns@goldelico.=
com>:
> > > >
> > > >>
> > > >> Am 11.09.2019 um 17:56 schrieb Adam Ford <aford173@gmail.com>:
> > > >>
> > > >>> There are some subtleties for testing.
> > > >>>
> > > >>> * I have added turbo-mode; to OPP6 / OPP1G
> > > >>> * which means they are available but not used by the ondemand gov=
enor
> > > >>> * to enable them one has to echo 1 >/sys/devices/system/cpu/cpufr=
eq/boost
> > > >>
> > > >> Will that be documented somewhere? If not, can we put a comment in=
 the
> > > >> device tree so people know how to enable it?
> > > >
> > > > It seems to be pretty standard on i86 systems if you google for "tu=
rbo mode".
> > > > I have added it to the commit message which adds the vbb regulator.
> > >
> > > And, I am not sure if DT maintainers will accept comments about the
> > > Linux /sys implementation in device tree files or bindings. Those
> > > should be independent of Linux.
> >
> > OK.
> > >
> > > Basically the turbo-mode property is a hint to the OPP system (which
> > > may or may not use of it).
> > >
> > > So I think it is indeed better to have it in the commit message and
> > > not the code.
> >
> > That makes sense.
> >
> > >
> > > One more thought: as long as we do not have junction temperature moni=
toring
> > > we should keep it off by default... We may even remove the turbo-mode
> > > designator if we have the 90=C2=B0C limit and smart reflex working.
>
> I found some info on the thermal framework [1].  It seems to show that
> we can put placeholders in the device tree to help facilitate this.
>
> An excerpt from [1]  shows:
>      Cooling devices provide control on power dissipation.
>      There are essentially two ways to provide control on power dissipati=
on.
>      First is by means of regulating device performance, which is
> known as passive cooling (DVFS).
>      ... [snip stuff about cooling fans]
>
> It also shows there are ways to link the cpu node to the cooling info.
> Since it shows DVFS can be used to regulate temperature, it seems like
> the hooks might already be in place
>
> [1] - https://blog.linuxplumbersconf.org/2015/ocw//system/presentations/2=
613/original/thermal-framework-status-no-transitioning.pdf
>
> The downside is that the OMAP thermal sensor is unreliable.

I submitted an RFC for thermal throttling.  I am not sure if I did it
right, and I don't have a good way to test it.

adam


> >
> > We're almost there!
> >
> > adam
> > >
> > > BR,
> > > Nikolaus
> > >
