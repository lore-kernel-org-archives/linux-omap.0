From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH v2 0/3] Enable CPU frequency and power tracking in cpuacct cgroup
Date: Thu, 20 May 2010 23:01:11 +0200
Message-ID: <201005202301.12259.trenn@suse.de>
References: <1274380944-20947-1-git-send-email-mike@android.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1274380944-20947-1-git-send-email-mike@android.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: menage@google.com, balbir@in.ibm.com, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Mike,

On Thursday 20 May 2010 08:42:21 pm Mike Chan wrote:
> v2:
> Rebased off of Thomas Renninger's patch for cgroups_cpuacct refactoring,
thanks.
A general comment:
I don't know much about the cgroup stuff.
I am also not sure how exactly power can be measured on this arch based on
frequency accounting (there also were some threads I was not aware of?)
A signed-off-by or reviewed-by from someone who is more involved in this omap
stuff would probably not that bad.

Still I Iike this interface and I could imagine others hook into it as well, 
for whatever has to be cpu cgroup accounted.

My two cents...,

     Thomas
