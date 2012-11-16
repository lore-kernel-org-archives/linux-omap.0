From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] usb: dwc3: core: move dwc3_cache_hwparams before dwc3_alloc_event_buffers
Date: Fri, 16 Nov 2012 16:08:11 +0400
Message-ID: <50A62CAB.90405@mvista.com>
References: <1353047874-4981-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353047874-4981-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 16-11-2012 10:37, Kishon Vijay Abraham I wrote:

> commit 392142

    Please specify thta commit summary in parens.

> moved event buffer allocation out of dwc3_core_init() but
> event buffer allocation uses the cached copy of hwparams to determine
> the number of event buffers and the caching is done in dwc3_core_init.
> So moved dwc3_cache_hwparams function before dwc3_alloc_event_buffers so
> that dwc3_alloc_event_buffers sees the correct number of event buffers.

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

WBR, Sergei
