From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 04/10] ARM: OMAP: omap_device: register to the per-device
 PM QoS framework
Date: Thu, 19 Jul 2012 04:21:29 -0500
Message-ID: <CAOMWX4eDOsM_oFjOZQuMnnN=T7a+3i_omiHrOGdvuEtu8PWbjA@mail.gmail.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
 <1339686361-11526-5-git-send-email-j-pihet@ti.com> <4FE1A8D4.1060003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FE1A8D4.1060003@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: khilman@ti.com, paul@pwsan.com, Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 20, 2012 at 5:41 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>>
>> +       /* Look for the platform device for the constraint target device
>> */
>> +       pdev = to_platform_device(dev_pm_qos_req->dev);
>> +
>> +       /* Try to catch non platform devices */
>> +       if (pdev->name == NULL) {
>
>
> Is this a safe way to catch non platform devices?

in addition, we should check !pdev before attempting to dereference
and check for pdev->name

Regards,
Nishanth Menon
