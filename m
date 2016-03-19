From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup
	for sidetone
Date: Sat, 19 Mar 2016 19:31:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603191908070.6629@utopia.booyaka.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 18 Mar 2016, Peter Ujfalusi wrote:

> The series addresses a long standing issue with McBSP2/3 regarding to hwmod
> setup. When booting with DT a warning is printed that mcbsp2/3 is using two
> hwmod.
> The root of the issue is the way how the hwmod data was constructed in the first
> place for OMAP3 McBSP2/3.
> After re-reading the TRM it is clear that the sidetone should not have it's
> own hwmod data as it is not a separate IP, it is part of the McBSP module.

Odd.  I come to exactly the opposite conclusion from reading the TRM.  In 
fact the SIDETONE blocks clearly should be hwmods, according to the 
documentation.

Consider:

1. The SIDETONE blocks have their own L4 ports - as documented in the 
OMAP36xx public TRM rev Z,  Table 2-5 "L4-Peripheral Memory Space".

2. The SIDETONE blocks have different register access width restrictions 
from the McBSP.  Ibid., Table 2-7 "Register Access Restrictions".

3. The SIDETONE blocks have distinct L4-Per firewall region IDs from their 
corresponding McBSP IP blocks.  Ibid., Table 9-114 "Region Allocation for 
L4-Per Interconnect".

4. The SIDETONE blocks have their own L4 target interconnect agents.  
Table 9-128 "L4-Per Instance Summary"

5. The SIDETONE blocks have their own MPU IRQ lines, distinct from the 
McBSP block IRQ lines.  Table 12-4 "Interrupt Mapping to the MPU 
Subsystem"

6. The SIDETONE IP block register target space is distinct from the 
corresponding McBSP address ranges.  Table 21-36 "McBSP Instance Summary"

7. The SIDETONE IP blocks have their own "TI OCP" integration registers.  
Table 21-134 "ST_REV_REG", Table 21-136 "ST_SYSCONFIG_REG".

A better solution to the warnings you mention at the top of the message is 
to provide a separate low-level McBSP SIDETONE IP block device driver, 
distinct from the existing McBSP low-level IP block driver.

> It can not affect PRCM either since it's SYSCONFIG register's AUTOIDLE 
> bit is only sets the autoidle from the internal McBSP_iclk clock to the 
> sidetone block of the same McBSP.

Can't parse this - could you try again?  Are you referring to the erratum 
where someone forgot to hook up the SIDETONE idle signals to the PRCM, and 
the MCBSP_ICLK has to be manually kept active when the SIDETONE block is 
active?


- Paul
