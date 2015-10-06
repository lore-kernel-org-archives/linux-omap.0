From: Belisko Marek <marek.belisko@gmail.com>
Subject: cpufreq-dt error: failed to init cpufreq table: -61
Date: Tue, 6 Oct 2015 15:25:35 +0200
Message-ID: <CAAfyv370DFbz9v8URqcipQt-AQ-6du19hf8di2fPeVfTdBzXww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

I'm using custom am33xx board where mpu voltage can be changed through
gpio regulator on 4.1 (latest stable) kernel. I defined gpio-regulator
node and also operating-points to DT. Gpio regulator seems to be
working fine but during probing cpufreq-dt I get error:
failed to init cpufreq table: -61

I did small investigation and seem that dev_pm_opp_init_cpufreq_table
fails at first condition dev_pm_opp_get_opp_count <= 0 and this is
because opp_list is empty. So it seems that any opp for am33xx aren't
defined if I'm getting it right. I did look to mach-omap2/opp3xxx_data
but there is nothing am33xx specific. It is known problem or exist
some patches around to fix that? Many thanks.

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
