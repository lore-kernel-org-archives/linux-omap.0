From: Nicholas Krause <xerofoify@gmail.com>
Subject: Re: [PATCH RESEND] mach-omap2:Remove calls to deprecacted marco,
 PTR_RET in the files, fb.c and pmu.c
Date: Wed, 20 May 2015 14:10:36 -0400
Message-ID: <4C6EB19A-6533-40E9-AD8B-CF0B9CB69D91@gmail.com>
References: <1431958079-486-1-git-send-email-xerofoify@gmail.com>
 <20150520180703.GI10274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150520180703.GI10274@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On May 20, 2015 2:07:03 PM EDT, Tony Lindgren <tony@atomide.com> wrote:
>* Nicholas Krause <xerofoify@gmail.com> [150518 07:09]:
>> This removes two calls to the deprecated marco,PTR_RET in
>> the files,fb.c and pmu.c for the functions,omap_init_vrfb
>> and omap_init_pmu respectfully. Furthermore these are now
>> replaced by calling the correctly non deprecacted function,
>> PTR_ERR_OR_ZERO in both functions.
>
>I've applied the original version today as they seem to be
>the same.
>
>Thanks,
>
>Tony
That's fine.  I just resent due to the rule about resending after a week. 
Nick

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
