From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 4/9] cpuidle: Introduce .abbr (abbrevation) for cpuidle states
Date: Wed, 12 Jan 2011 14:37:50 +0100
Message-ID: <201101121437.51122.trenn@suse.de>
References: <1294396190-23031-1-git-send-email-trenn@suse.de> <1294396190-23031-5-git-send-email-trenn@suse.de> <alpine.LFD.2.02.1101120150570.19140@x980>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1101120150570.19140@x980>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, j-pihet@ti.com, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 12 January 2011 07:56:45 Len Brown wrote:
> I'm not fond of inventing a new 3-character abbreviation field
> for every state because display tools can't handle the existing
> 16-character name field.
I am also not "fond" of it, but it's a sane and easy
solution and appropriate for this issue.
 
> If the display tools can only handle 3 characters,
> then why not have them simply use the 1st 3 characters
> of the existing name field?
You mean use:
C3 NHM
instead of
NHM-C3
for intel_idle?

Then userspace has to parse the two informations glued
together, get rid of the whitespace, etc.
But by sysfs convention a separate file must be used
if two data are passed to userspace which is the case here.

> If that is not unique,
> then re-arrange the strings so that it is unique...
See above, it would unnecessarily make life hard for
userspace.
Afaik sysfs entries do not consume resources as long as
they do not get accessed.

> Of course the ACPI part of this patch will not apply,
> as it depends on patch 1 in this series, which was erroneous.
> For ACPI, the existing name field is already fine,
> as C%d fits into 3 characters.
For acpi_idle only it would work, but this is (nearly) the only
one.
For example for sh arch:
name: SuperH
"SH SuperH" contains two data and should get split up into:
name: SuperH
abbr: SH

By convention the first characters of "description" could be
used, but you would again end up in userspace parsing and
double info in one sysfs file.

I hope that's enough for convincing, I'd really like to go
the .abbr way. Do you give me an acked-by for that one?

Thanks,

    Thomas
