From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCHv4 0/4] OMAP: Serial: remove magic and diplicates
Date: Fri, 12 Nov 2010 18:47:13 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC24F05C@dbde02.ent.ti.com>
References: <1289567043-6213-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1289567043-6213-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>linu
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Emeltchenko Andrei
> Sent: Friday, November 12, 2010 6:34 PM
> To: linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org; 
> linux-arm@lists.arm.linux.org.uk; linux-serial@vger.kernel.org
> Subject: [PATCHv4 0/4] OMAP: Serial: remove magic and diplicates

s/diplicates/duplicates

> 
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Add MDR1 Serial register definition to serial_reg and remove 
> duplicated
> code, remove magic MDR1 register numbers from serial drivers.
> 
> *v2 add OMAP keyword to MDR1 definition
> *v3 remove magic from serial drivers
> *v4 taking comments from Manjunath and Govindraj: typos, CC
> 
> Andrei Emeltchenko (4):
>   OMAP: Serial: Define OMAP uart MDR1 register definitions
>   OMAP1: Serial: remove magic numbers for MDR1 reg
>   OMAP2: Serial: remove magic numbers for MDR1 reg
>   OMAP: Serial: remove redefined MDR1 register definitions
> 
>  arch/arm/mach-omap1/serial.c                  |    6 ++++--
>  arch/arm/mach-omap2/serial.c                  |   15 +++++++++------
>  arch/arm/plat-omap/include/plat/omap-serial.h |    3 ---
>  drivers/serial/omap-serial.c                  |    6 +++---
>  include/linux/serial_reg.h                    |   12 ++++++++++++
>  5 files changed, 28 insertions(+), 14 deletions(-)

Do you think patch series is required for these changes? How about
merging with single patch? 

-Manjunath


