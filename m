From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 1/5] ARM: dts: am33xx: Add updated operating-points-v2
 table for cpu
Date: Mon, 6 Mar 2017 17:01:08 +0100
Message-ID: <20170306170108.01994fde@jawa>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
 <1488813822-26042-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488813822-26042-2-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, Yegor Yefremov <yegorslists@googlemail.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 6 Mar 2017 09:23:38 -0600
Dave Gerlach <d-gerlach@ti.com> wrote:

> After the ti-cpufreq driver has been added, we can now drop the
> operating-points table present in am33xx.dtsi for the cpu and add an
> operating-points-v2 table with all OPPs available for all silicon
> revisions. Also add necessary data for use by ti-cpufreq to
> selectively enable the appropriate OPPs at runtime as part of the
> operating-points table.
> 
> Information from AM335x Data Manual, SPRS717i, Revised December 2015,
> Table 5-7.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
