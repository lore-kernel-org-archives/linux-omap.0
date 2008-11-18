From: "Sriram V" <vshrirama@gmail.com>
Subject: Howto test OFF Mode Support
Date: Tue, 18 Nov 2008 20:55:24 +0530
Message-ID: <8bf247760811180725u293655e4ve7d133b1448d5412@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:60231 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYKRPZ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 10:25:27 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2499770fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 07:25:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
   I am using I am using the pm-20081106 on omap3evm.
   I am trying to test if various pwr domains are set to OFF State.
   Basically i want to test if various power domains (mpu/core) are being
   set to different states
    i see that core/mpu domain does not enter OFF/RET state.

    $ /debug/pm_debug # cat count
      usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
     sgx_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
     per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
     dss_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
     cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
     core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
     neon_pwrdm (ON),OFF:0,RET:0,INA:7646,ON:7647
    mpu_pwrdm (ON),OFF:0,RET:0,INA:7646,ON:7647
    iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1

   I notice that with pm support enable. The entire system is somewhat slow.
   uart responses are very slow. has anyone observed this before?

   Are these states depended on clocks on/off? ie if i put the states
   to OFF/RET should i take care of the clocks too?

    On running powertop, I see states upto C4 only.
   i can see changes across C0, C2, C4 states.

    PowerTOP version 1.9       (C) 2007 Intel Corporation

      Cn                Avg residency       P-states (frequencies)
      C0 (cpu running)        ( 0.2%)
      C1                0.0ms ( 0.0%)
      C2                4.8ms ( 0.3%)
      C3                7.3ms ( 0.5%)
      C4                0.0ms ( 0.0%)

     Wakeups-from-idle per second :  3.0     interval: 3.0s

   I tried to set sysfs entry enable_off_mode = 1, I can see that some
of the domains
   are set to OFF mode through debug print. But not core/mpu domains.

   Is there any reason why off mode can be set manually and not
through cpu idle?

   has anyone tried this with pm-20081106.

   Are there any utilities/methods to test cpu idle/pm in general other than
   analyzing these debug prints.

   am looking at power tester.

Regards,
sriram
