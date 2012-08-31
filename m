From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 10/23] OMAPDSS: DPI: Pass omap_dss_output within the
 driver
Date: Fri, 31 Aug 2012 19:30:03 +0530
Message-ID: <5040C363.1090406@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>  <1346326845-16583-1-git-send-email-archit@ti.com>  <1346326845-16583-11-git-send-email-archit@ti.com> <1346420930.7508.9.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58604 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787Ab2HaN7t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 09:59:49 -0400
In-Reply-To: <1346420930.7508.9.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 31 August 2012 07:18 PM, Tomi Valkeinen wrote:
> On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
>> When a panel driver calls a DPI function, it passes the omap_dss_device
>> pointer, this pointer currently propagates within the DPI driver to configure
>> the interface.
>>
>> Extract the omap_dss_output pointer from omap_dss_device received from the panel
>> driver, pass the output pointer to DPI functions local to the driver to
>> configure the interface, these functions no longer need omap_dss_device since
>> the driver now maintains a copy of output parameters.
>>
>> Replace dssdev->manager references with out->manager references as only these
>> will be valid later.
>>
>> With the addition of outputs. There is a possibility that an omap_dss_device
>> isn't connected to an output, or a manager isn't connected to an output yet.
>> Ensure that the DPI interface functions proceed only if the output is non NULL.
>
> I agree with the direction of this and the similar patches for other
> outputs, but I think we should leave these out for now, at least most of
> the code here.
>
> So ultimately we'll have the output drivers taking the omap_dss_output
> as an argument, and we don't need dssdev anymore. But we can't do that
> yet, and now that you mix both approaches I think the end result makes
> the code a bit more confusing, and it would be changed again later when
> dssdev can be removed.
>
> What I mean is that, for example, display_enable takes dssdev as an
> argument. Then you extract output from that, and pass output to some
> other functions. Then these functions again extract dssdev from the
> output.
>
> This feels like extra churn that doesn't really help anything, and will
> be changed later when the functions get output as an argument. So I
> propose to keep passing dssdev around until we've removed the
> dependencies to dssdev, and we (probably) get the output directly as an
> argument to the functions. Then we can clean them up properly at one go.
>
> The dssdev->manager parts still need to be changed to out->manager, of
> course, but I think those are minority of the changes here and the
> following patches.

Ok. Yes, I guess if we start from here, we would need to do unnecessary 
changes once we completely switch to outputs.

I'll change these output patches such that, only the dssdev->manager 
references are fixed to dssdev->output->manager.

Archit

