From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] remoteproc: block premature rproc booting
Date: Wed, 6 Jun 2012 08:44:17 +0300
Message-ID: <CAK=WgbakMG5eoSGP3GDFLFjA=z5fc_h_oFdzuC4tL5PcpCdLZA@mail.gmail.com>
References: <1337687472-23009-1-git-send-email-ohad@wizery.com>
 <4FBDFC4A.1060602@codeaurora.org>
 <CAK=WgbaP5qSso_Eu=Oup4eqLDcorZ-qf=mysMKiEvOS=m7yLmg@mail.gmail.com>
 <4FCD276A.80505@codeaurora.org>
 <CAK=WgbZo-8GXY9bVYGk0XZvqKrdaJZWeNkK1FhRWnH5doGYLjA@mail.gmail.com>
 <4FCECD8F.8000600@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FCECD8F.8000600@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <fernando.lugo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 6, 2012 at 6:25 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> What if I don't want to boot the device at kernel start-up? Do I have to
> make it a module then?

Currently, yeah.

But we can change stuff if needed.

We took that design decision because it was simple and we didn't have
any reason not to do it, but I'm thinking we can let the users decide
about this using runtime pm (e.g. calling pm_runtime_get_sync with an
rpmsg device, which will then be propagated all the way up to the
remoteproc device and power it up).
