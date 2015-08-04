From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v2 3/3] soc: ti: Add wkup_m3_ipc driver
Date: Tue, 4 Aug 2015 15:58:41 -0500
Message-ID: <55C12781.1070007@ti.com>
References: <1437166592-25378-1-git-send-email-d-gerlach@ti.com>
 <1437166592-25378-4-git-send-email-d-gerlach@ti.com>
 <20150720061559.GX17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150720061559.GX17550@atomide.com>
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
Cc: devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/20/2015 01:16 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [150717 13:59]:
>> +
>> +/* Public functions */
> ...
>> +EXPORT_SYMBOL_GPL(wkup_m3_set_mem_type);
>> +EXPORT_SYMBOL_GPL(wkup_m3_set_resume_address);
>> +EXPORT_SYMBOL_GPL(wkup_m3_request_pm_status);
>> +EXPORT_SYMBOL_GPL(wkup_m3_prepare_low_power);
>> +EXPORT_SYMBOL_GPL(wkup_m3_finish_low_power);
>
> I think you can avoid exporting these SoC specific functions
> by just exporting wkup_m3_request() and wkup_m3_free() type
> functions with a data structure containing the necessary
> function pointers.

Ok thanks for the comment, I can try that change out, I agree it 
probably isn't necessary to export so much.

Regards,
Dave

>
> Regards,
>
> Tony
>
