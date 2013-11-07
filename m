From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH 00/11] Embeddable Position Independent Executable
Date: Thu, 7 Nov 2013 15:29:38 -0800
Message-ID: <CAGa+x85AJ6e4W3S73cv_ZJtb+uCLYTMk_DPmQO3Nj656-7QJMg@mail.gmail.com>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, linux-kbuild@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, mans@mansr.com, Shawn Guo <shawn.guo@linaro.org>, Dave Martin <Dave.Martin@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 17, 2013 at 5:43 AM, Russ Dill <Russ.Dill@ti.com> wrote:
> This patch adds support for and demonstrates the usage of an embedded
> position independent executable (PIE). The goal is to allow the use of C
> code in situations where carefully written position independent assembly
> was previously required.

Hmm, I thought I had already replied to this but it appears that I haven't.

I really like this approach and think it's a major improvement on what
we're already doing on OMAP and a few other ARM platforms.  This
approach is done in a way that's significantly easier to maintain and
extend IMO.

As a next step, I think you should drop the RFC and split it up into a
few series that can go via the right trees:

- asm-generic and lib/devres (patches 1, 2, 4)
- drivers/sram (patch 3)
- generic PIE: (patch 5)
- core PIE: (patch 5-8)
- AM33xx support (patch 9-11)

Kevin
