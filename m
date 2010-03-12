From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCHv2 0/3] Add support for TCA6416 based Keypad driver.
Date: Sat, 13 Mar 2010 02:08:20 +0530
Message-ID: <5d5443651003121238l7fb1c5b1rbcbea660c5cf83c@mail.gmail.com>
References: <1268385499-7075-1-git-send-email-srk@ti.com>
	 <6ed0b2681003120323r2a1b72a9m344d71431ebcd7c4@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC356087030445C4A7@dbde02.ent.ti.com>
	 <20100312172943.GH2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58902 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757211Ab0CLUiV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 15:38:21 -0500
In-Reply-To: <20100312172943.GH2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindarajan, Sriramakrishnan" <srk@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

On Fri, Mar 12, 2010 at 10:59 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindarajan, Sriramakrishnan <srk@ti.com> [100312 03:39]:
>>
>> > Please fix mode - remove +x flags.
>>
>> [Sriram] Thanks for pointing out. I will await further review comments
>> And post the updated version thereafter
>
> Please fix mode change issue at TI in general.
>
> We're getting these executable mode change patches from TI on regular basis.
>

Better way to add checking +x attribute support internally in
checkpatch.pl and let everybody scan through checkpatch.pl before
submitting a patch to ML. It works !!!



-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
