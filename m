From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/4] cpupower: Add cpupower-idle-info manpage
Date: Fri, 16 Dec 2011 17:18:37 +0100
Message-ID: <CAORVsuVrm+dWGgs-taatnUMZsYvYg_tdx1=7ekWp0qM+25DorQ@mail.gmail.com>
References: <1324046154-64824-1-git-send-email-trenn@suse.de>
	<1324046154-64824-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1324046154-64824-2-git-send-email-trenn@suse.de>
Sender: cpufreq-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux@dominikbrodowski.net, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Thomas,

On Fri, Dec 16, 2011 at 3:35 PM, Thomas Renninger <trenn@suse.de> wrote:
> The last missing manpage for cpupower tools.
Great!

> More info about other architecture's sleep state specialities would be great.
I wonder if it is the right place for some arch specific information
about the sleep states.

I propose to document this in a more generic doc file (e.g.
Documentation/arm/OMAP/omap_pm) and link it from the manpage.

What do you think?

>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: linux-arm-kernel@lists.infradead.org
> CC: jean.pihet@newoldbits.com
> CC: linux-omap@vger.kernel.org
> CC: linux-pm@lists.linux-foundation.org
> CC: linux-acpi@vger.kernel.org
> CC: cpufreq@vger.kernel.org
> CC: linux@dominikbrodowski.net

Regards,
Jean
