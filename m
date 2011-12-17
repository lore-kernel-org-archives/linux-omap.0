From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/4] cpupower: Add cpupower-idle-info manpage
Date: Sat, 17 Dec 2011 10:21:57 +0100
Message-ID: <201112171021.58492.trenn@suse.de>
References: <1324046154-64824-1-git-send-email-trenn@suse.de>
	<1324046154-64824-2-git-send-email-trenn@suse.de>
	<CAORVsuVrm+dWGgs-taatnUMZsYvYg_tdx1=7ekWp0qM+25DorQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAORVsuVrm+dWGgs-taatnUMZsYvYg_tdx1=7ekWp0qM+25DorQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org, linux@dominikbrodowski.net, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 16 December 2011 17:18:37 Jean Pihet wrote:
> Hi Thomas,
> 
> On Fri, Dec 16, 2011 at 3:35 PM, Thomas Renninger <trenn@suse.de> wrote:
> > The last missing manpage for cpupower tools.
> Great!
> 
> > More info about other architecture's sleep state specialities would be great.
> I wonder if it is the right place for some arch specific information
> about the sleep states.
> 
> I propose to document this in a more generic doc file (e.g.
> Documentation/arm/OMAP/omap_pm) and link it from the manpage.
Duplicating info at different places increases needed maintenance.
Mabye above should be more about the kernel implementation details
and the manpage should more include the bits a typical user
wants to know?

> What do you think?
The POLL state is a bit confusing on X86 cpupower idle-info output.
Also on X86 the CPU may decide to use other states than the kernel
requested and the cpupower monitor tool should get used to see them.
This directly affects the output/usage of the tool and to understand it,
it should be documented in the manpage.

IMO it's not bad to have a somewhat bigger manpage here.
Especially on ARM, also the "ordinary" user wants to know
about how/whether the cpu power functionalities work as expected
without the need of looking at the kernel sources.

For now I could only try out cpupower on an ARM platform
with cpufreq support.
Would be great if someone could give cpupower idle-info
a try on such a machine.
Think of a typical user, not a kernel hacker and what he needs to
know to interpret and understand the output.
Maybe it's self-explanatory already, maybe the one or other arch
specific bit should get explained?

   Thomas
