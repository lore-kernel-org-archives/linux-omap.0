From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V3 12/15] ARM: vexpress: cleanup cppcheck shifting error
Date: Tue, 25 Jun 2019 18:24:42 +0100
Message-ID: <20190625172442.GA19852@e107155-lin>
References: <20190624135105.15579-1-tranmanphong@gmail.com>
 <20190625040356.27473-1-tranmanphong@gmail.com>
 <20190625040356.27473-13-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190625040356.27473-13-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 25, 2019 at 11:03:53AM +0700, Phong Tran wrote:
> There is error from cppcheck tool
> "Shifting signed 32-bit value by 31 bits is undefined behaviour errors"
> change to use BIT() marco for improvement.
>

What's your plan for merging this series ? I can take this for v5.4
If not,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
