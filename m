From: Ran Shalit <ranshalit@gmail.com>
Subject: "no opp match" error
Date: Fri, 20 Mar 2015 17:29:40 +0200
Message-ID: <CAJ2oMhK=gF+wfb-Rndas8RFi2b3sK6zHet+Q9dicLGObVNboKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

I get in boot of board the following error:
"omap_target: cpu0: no opp match for freq 900000".
I see that the failure is in function cpufreq->opp_find_freq_exact().

Does is mean that cpufreq fails and do nothing ?
How can I fix this error ?

Regards,
Ran
