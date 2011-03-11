From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [ANNOUNCE] cpupowerutils - cpufrequtils extended with quite some features
Date: Fri, 11 Mar 2011 15:56:01 +0000
Message-ID: <AANLkTimFg+uYGbSi=Ci-+_e89TgLkyMB7PAJcnt7mzTc@mail.gmail.com>
References: <201103111247.00212.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201103111247.00212.trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, discuss@lesswatts.org, power@bughost.org, cpufreq@vger.kernel.org, linux@dominikbrodowski.net, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, herrmann.der.user@googlemail.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 11, 2011 at 11:46 AM, Thomas Renninger <trenn@suse.de> wrote:
> Why is there need for another tool?
> -----------------------------------
>
> CPU power consumption vs performance tuning is not about
> CPU frequency switching anymore for quite some time.
> Deep sleep states, traditional dynamic frequency scaling and
> hidden turbo/boost frequencies are tight close together and
> depend on each other. The first two exist on different architectures
> like PPC, Itanium and ARM the latter only on X86.
> On X86 the APU (CPU+GPU) will only run most efficiently if CPU
> and GPU has proper power management in place.
>
> Users and Developers want to have *one* tool to get an overview what their
> system supports and to monitor and debug CPU power management in detail.
>
> The tool should compile and work on as much architectures as
> possible.
>

Hi Thomas,
Do you think handling really vendor specific "boosts" like EeePC's SHE
is in cpupower scope ?
Still, it would not solve the issue of setting SHE mode in a standard
way, or associating it with a governor.
Thanks,

-- 
Corentin Chary
http://xf.iksaif.net
