From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 1/2] cpufreq: OMAP: Handle missing frequency table on
 SMP systems
Date: Thu, 09 Aug 2012 08:00:50 -0700
Message-ID: <87d330glel.fsf@ti.com>
References: <1344496102-24451-1-git-send-email-rnayak@ti.com>
 <1344496102-24451-2-git-send-email-rnayak@ti.com>
 <201208091132.14992.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201208091132.14992.rjw@sisk.pl> (Rafael J. Wysocki's message of
 "Thu, 9 Aug 2012 11:32:14 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Thursday, August 09, 2012, Rajendra Nayak wrote:
>> On OMAP4, if the first CPU fails to get a valid frequency table (this
>> could happen if the platform does not register any OPP table), the
>> subsequent CPU instances end up dealing with a NULL freq_table and
>> crash.
>> 
>> Check for an already existing freq_table, before trying to create one,
>> and increment the freq_table_users only if the table is sucessfully
>> created.
>> 
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: <linux-pm@vger.kernel.org>
>
> Kevin, are you going to merge this?
>

Yes, I plan to queue this with 2/2 for v3.6-rc.

Kevin
