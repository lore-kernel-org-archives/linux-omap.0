From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra7: Set a default parent to mcasp3_ahclkx_mux
Date: Tue, 19 Sep 2017 10:45:40 -0700
Message-ID: <20170919174539.GB5024@atomide.com>
References: <1504705172-17781-1-git-send-email-j-keerthy@ti.com>
 <c1d80795-f86c-23e4-5a6b-4829c0f9f8a0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c1d80795-f86c-23e4-5a6b-4829c0f9f8a0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [170918 04:35]:
> 
> 
> On Wednesday 06 September 2017 07:09 PM, Keerthy wrote:
> > Assign a default parent to mcasp3_ahclkx_mux clock using
> > the assigned-clock-parents property. This is helpful in
> > cases like kexec where in the clock parent can be something
> > other than the value at reset.
> 
> Hi Tony,
> 
> A gentle ping on this.

Applying into omap-for-v4.14/fixes thanks.

Tony
