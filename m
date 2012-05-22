From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/7] remoteproc: resource table overhaul
Date: Tue, 22 May 2012 11:02:14 +0300
Message-ID: <CAK=WgbYSrzTKW-QME4-r6XhVAQL0b6iWyus632KZOpfpTPgwWg@mail.gmail.com>
References: <1330589497-4139-1-git-send-email-ohad@wizery.com>
 <1330589497-4139-2-git-send-email-ohad@wizery.com>
 <4F6354E4.8030704@monstr.eu>
 <CAK=Wgbbbi4GnuHedSh6cR1LhkZr8c9q6i=_TLSL252LpPB8Xsw@mail.gmail.com>
 <CAK=WgbYeQr5ZwTSBo+ZJUzN7fQ--0QbC8HSjrGT-Geycs4SKcg@mail.gmail.com>
 <CAHTX3d+=QTZo994jct6+pPqsCniG0B2a_9q6fLdGjvcbZ7qj_A@mail.gmail.com>
 <CAK=WgbahzGHmvszw6HBgihN4NcPA8ceaQCNSOk_FC61bToxBXQ@mail.gmail.com>
 <CAHTX3dK8rDomYqWvBX1ay200AmM1dBCYD3nJ2UYbzC_SSFankw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHTX3dK8rDomYqWvBX1ay200AmM1dBCYD3nJ2UYbzC_SSFankw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <monstr@monstr.eu>
Cc: Ludovic BARRE <ludovic.barre@stericsson.com>, Anna Suman <s-anna@ti.com>, Guzman Lugo Fernando <fernando.lugo@ti.com>, Arnd Bergmann <arnd@arndb.de>, Iliyan Malchev <malchev@google.com>, Brian Swetland <swetland@google.com>, Loic PALLARDY <loic.pallardy@stericsson.com>, Rusty Russell <rusty@rustcorp.com.au>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Saravana Kannan <skannan@codeaurora.org>, John Williams <john.williams@petalogix.com>, Clark Rob <rob@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-omap@vger.kernel.org, Kieran Bingham <kieranbingham@gmail.com>, Mark Grosen <mgrosen@ti.com>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Hi Michal,

On Tue, May 22, 2012 at 8:51 AM, Michal Simek <monstr@monstr.eu> wrote:
> Simple enabling RSC_VDEV in rproc_handle_rsc doesn't work.

Sure - you'll need to actually plug the vrings allocation code there,
too (i.e. this requires some coding, it's not a 1-liner).

> BTW: I am using kernel modules and there is no dependency for
> virtio_rpmsg_bus in remoteproc module
> in sense if you load remoteproc module you also need to load
> virtio_rpmsg_bus to get firmware to work.

This is expected: remoteproc only provides means for booting and
controlling remote processors and it doesn't boot them upfront.

To actually boot a remote processor, and do something useful with it,
one needs to load a module which utilizes remoteproc's API (e.g.
virtio_rpmsg_bus, but YMMV).

> ~ # lsmod
> ~ # modprobe zynq_remoteproc
> zynq_remoteproc: Unknown symbol rproc_register (err 0)
> zynq_remoteproc: Unknown symbol rproc_alloc (err 0)
> zynq_remoteproc: Unknown symbol rproc_vq_interrupt (err 0)
> zynq_remoteproc: Unknown symbol rproc_free (err 0)
> zynq_remoteproc: Unknown symbol rproc_unregister (err 0)

We don't have these errors - have you tried looking into them ?

Btw do you plan on submitting the code for zynq_remoteproc ?

> Can you see the same behavior on omap?

Except the "Unknown symbol" errors, everything else looks good.

Thanks,
Ohad.
