From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v5 1/3] usb: dwc3: msm: Add device tree binding information
Date: Mon, 23 Sep 2013 16:03:18 -0600
Message-ID: <5240BAA6.9090509@wwwdotorg.org>
References: <1377091786-5613-1-git-send-email-iivanov@mm-sol.com> <1377091786-5613-2-git-send-email-iivanov@mm-sol.com> <20130923193224.GO30811@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130923193224.GO30811@radagast>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, idos-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 09/23/2013 01:32 PM, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Aug 21, 2013 at 04:29:44PM +0300, Ivan T. Ivanov wrote:
>> From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
>> 
>> MSM USB3.0 core wrapper consist of USB3.0 IP from Synopsys (SNPS)
>> and HS, SS PHY's control and configuration registers.
>> 
>> It could operate in device mode (SS, HS, FS) and host mode (SS,
>> HS, FS, LS).
>> 
>> Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> 
> and here's a new version from same patch

The binding looks pretty simple, so I don't think it's too contentious.

>> diff --git a/Documentation/devicetree/bindings/usb/msm-ssusb.txt
>> b/Documentation/devicetree/bindings/usb/msm-ssusb.txt

>> +MSM DWC3 controller wrapper

>> +Optional properties : +- gdsc-supply : phandle to the globally
>> distributed switch controller +  regulator node to the USB
>> controller.

If that's a regulator node, why not use xxx-supply properties to
interface with it?

Aside from that, the binding,
Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
