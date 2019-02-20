From: Adam Ford <aford173@gmail.com>
Subject: Re: da850 dt cpufreq support
Date: Wed, 20 Feb 2019 09:58:49 -0600
Message-ID: <CAHCN7xK4PjCfNgJeQ97kQGOJfjJ927igFELWniu6kuzgJ-Hgiw@mail.gmail.com>
References: <ccdb73e4-e4eb-2552-b62f-6cf57929dfee@acn-group.ch>
 <20190220154658.GP15711@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190220154658.GP15711@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Christophe Aeschlimann <c.aeschlimann@acn-group.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 20, 2019 at 9:47 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> Adding Bartosz, David and Sekhar to Cc.
>
> * Christophe Aeschlimann <c.aeschlimann@acn-group.ch> [190220 15:34]:
> > Hi,
> >
> > I understand that today the da850-evm is supported in two ways in the
> > Kernel, using board file, aka "legacy" and device-tree.
> >
> > Am I right to say that when using the device-tree there is no support for
> > cpufreq available ?
> >
> > The "ti-cpufreq" driver doesn't target the da850 SoC and the
> > "davinci-cpufreq" driver doesn't make use of the device-tree bindings.
> >
> > Could the generic "cpufreq-dt" driver be used ?

A while ago, David L posted a message on the mailing list pointing to
a git repo that hat some patches that weren't mainlined.

https://github.com/dlech/linux/tree/da850-dt-cpufreq

I was going to try and test them, but I never got around to it due to
other work projects.

adam
> >
> > Best regards,
> >
> > Christophe
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
