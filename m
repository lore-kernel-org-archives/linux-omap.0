From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/9] DSPBRIDGE: trivial checkpatch fixes
Date: Wed, 25 Nov 2009 15:37:24 -0600
Message-ID: <4B0DA394.2030705@ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com> <1259023830-7557-2-git-send-email-omar.ramirez@ti.com> <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59060 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759172AbZKYVhY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Nov 2009 16:37:24 -0500
In-Reply-To: <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Ramirez Luna, Omar had written, on 11/23/2009 06:50 PM, the following:
> Quick fixes like:
General comment: please do white space changes as a separate patch. this 
massive patch is pretty difficult to review otherwise.. might have been 
as simple as doing scripts/Lindent on all files and refixing with 
scripts/checkpatch.pl ..

[...]

> diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
> index e9cb548..13b1ff6 100644
> --- a/arch/arm/plat-omap/include/dspbridge/dbc.h
> +++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
> @@ -36,7 +36,7 @@
> 
>  #define DBC_Assert(exp) \
>      if (!(exp)) \
> -       printk("%s, line %d: Assertion (" #exp ") failed.\n", \
> +       printk(KERN_ERR "%s, line %d: Assertion (" #exp ") failed.\n", \

Not in the context of this patch, but we definitely need another series 
killing these printks into pr_xxxx family..

>         __FILE__, __LINE__)
>  #define DBC_Require DBC_Assert /* Function Precondition.  */
>  #define DBC_Ensure  DBC_Assert /* Function Postcondition. */
> diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
> index bae19e7..1a7d5fa 100644
> --- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
> +++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
> @@ -21,9 +21,9 @@
> 
>  #include <linux/types.h>
> 
> -#include <dspbridge/dbtype.h>          /* GPP side type definitions           */
> -#include <dspbridge/std.h>             /* DSP/BIOS type definitions           */
> -#include <dspbridge/rms_sh.h>          /* Types shared between GPP and DSP    */
> +#include <dspbridge/dbtype.h>          /* GPP side type definitions */
> +#include <dspbridge/std.h>             /* DSP/BIOS type definitions */
> +#include <dspbridge/rms_sh.h>          /* Types shared between GPP and DSP */
> 
>  #define PG_SIZE_4K 4096
>  #define PG_MASK(pg_size) (~((pg_size)-1))
> @@ -553,7 +553,7 @@ bit 6 - MMU element size = 64bit (valid only for non mixed page entries)
>  #define AUTOSTART      "AutoStart"             /* Statically load flag */
>  #define CURRENTCONFIG  "CurrentConfig"         /* Current resources */
>  #define SHMSIZE                "SHMSize"               /* Size of SHM reservd on MPU */
> -#define TCWORDSWAP     "TCWordSwap"            /* Traffic Contoller Word Swap */
> +#define TCWORDSWAP     "TCWordSwap"            /* Traffic Controller WordSwp */
>  #define DSPRESOURCES   "DspTMSResources"       /* C55 DSP resurces on OMAP */
> 
>  #endif                         /* DBDEFS_ */
> diff --git a/arch/arm/plat-omap/include/dspbridge/gt.h b/arch/arm/plat-omap/include/dspbridge/gt.h
> index b43b1e7..c110234 100644
> --- a/arch/arm/plat-omap/include/dspbridge/gt.h
> +++ b/arch/arm/plat-omap/include/dspbridge/gt.h
> @@ -232,7 +232,7 @@ extern struct GT_Config _GT_params;
> 
>  #define GT_assert(mask, expr) \
>         (!(expr) ? \
> -           printk("assertion violation: %s, line %d\n", \
> +           printk(KERN_ERR "assertion violation: %s, line %d\n", \
>                             __FILE__, __LINE__), NULL : NULL)
> 
>  #define GT_config(config)     (_GT_params = *(config))
> diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
> index b8f4fb7..77f9e25 100644
> --- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
> +++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
> @@ -291,13 +291,13 @@
> 
>         extern void IO_IntrDSP2(IN struct IO_MGR *pIOMgr, IN u16 wMbVal);
> 
> -       extern void IO_SM_init(void);
> +       extern void IO_SM_init(void);
> 
>  /*
>   *  ========PrintDspTraceBuffer ========
>   *      Print DSP tracebuffer.
>   */
no comments ;)

> -       extern DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT
> -                                               *hWmdContext);
> +       extern DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT
> +                                               *hWmdContext);
> 
>  #endif                         /* IOSM_ */
> diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
> index b213b82..397361c 100644
> --- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
> +++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
> @@ -54,7 +54,7 @@ union Trapped_Args {
>         } ARGS_MGR_UNREGISTEROBJECT;
> 
>         struct {
> -               struct DSP_NOTIFICATION  __user*__user *aNotifications;
> +               struct DSP_NOTIFICATION  __user *__user *aNotifications;

include/linux/compiler.h
# define __user         __attribute__((noderef, address_space(1)))

Trying to understand this seemingly  interesting double usage of __user

>                 u32 uCount;
>                 u32 __user *puIndex;
>                 u32 uTimeout;
> @@ -111,7 +111,7 @@ union Trapped_Args {
>         struct {
>                 DSP_HPROCESSOR hProcessor;
>                 s32 iArgc;
> -               char __user*__user *aArgv;
> +               char __user *__user *aArgv;
>                 char *__user *aEnvp;
>         } ARGS_PROC_LOAD;
> 
> diff --git a/drivers/dsp/bridge/dynload/reloc.c b/drivers/dsp/bridge/dynload/reloc.c
> index d4457c5..b9e2a9b 100644
> --- a/drivers/dsp/bridge/dynload/reloc.c
> +++ b/drivers/dsp/bridge/dynload/reloc.c
> @@ -195,20 +195,22 @@ void dload_relocate(struct dload_state *dlthis, TgtAU_t *data,
>                 rx = HASH_L(rop_map2[rx]);
>                 if (rx < 0) {
>  #if TMS32060

???? do we support others now?

> -               switch (rp->r_type) {
> -               case R_C60ALIGN:
> -               case R_C60NOCMP:
> -               case R_C60FPHEAD:
> -                   /* Ignore these reloc types and return */
> -                   break;
> -               default:
> -                   /* Unknown reloc type, print error and return */
> -                   dload_error(dlthis, "Bad coff operator 0x%x", rp->r_type);
> -           }
> +                       switch (rp->r_type) {
> +                       case R_C60ALIGN:
> +                       case R_C60NOCMP:
> +                       case R_C60FPHEAD:
> +                               /* Ignore these reloc types and return */
> +                               break;
> +                       default:
> +                               /* Unknown reloc type, print error and return */
> +                               dload_error(dlthis, "Bad coff operator 0x%x",
> +                                               rp->r_type);

we probably need to remove these custom print messages.

> +                       }
>  #else
> -           dload_error(dlthis, "Bad coff operator 0x%x", rp->r_type);
> +                       dload_error(dlthis, "Bad coff operator 0x%x",
> +                                       rp->r_type);
>  #endif
> -           return;
> +                       return;
>                 }
>         }
>         rx = HASH_I(rop_map2[rx]);
> @@ -216,7 +218,8 @@ void dload_relocate(struct dload_state *dlthis, TgtAU_t *data,
>            && (rx < (sizeof(rop_info)/sizeof(uint_least16_t))) && (rx > 0)) {
>                 reloc_action = rop_action[rx]; reloc_info = rop_info[rx];
>         } else {
> -           dload_error(dlthis, "Buffer Overflow - Array Index Out of Bounds");
> +               dload_error(dlthis, "Buffer Overflow - Array Index Out "
> +                               "of Bounds");
>         }
> 
>         /* Compute the relocation amount for the referenced symbol, if any */
> diff --git a/drivers/dsp/bridge/gen/_gt_para.c b/drivers/dsp/bridge/gen/_gt_para.c
> index 9f8246b..dd22f77 100644
> --- a/drivers/dsp/bridge/gen/_gt_para.c
> +++ b/drivers/dsp/bridge/gen/_gt_para.c
> @@ -77,7 +77,7 @@ static void error(char *fmt, ...)

error: Dont think we should have custom error reporting mechanisms.

> 
>         va_end(va);
> 
> -       printk("ERROR: ");
> +       printk(KERN_ERR "ERROR: ");

Nak.

>         printk(fmt, arg1, arg2, arg3, arg4, arg5, arg6);
> 
[...]

> diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
> index 0bbee3c..979778d 100644
> --- a/drivers/dsp/bridge/pmgr/cod.c
> +++ b/drivers/dsp/bridge/pmgr/cod.c
> @@ -368,7 +368,7 @@ DSP_STATUS COD_GetBaseName(struct COD_MANAGER *hManager, char *pszName,
>         DBC_Require(pszName != NULL);
> 
>         if (uSize <= COD_MAXPATHLENGTH)
> -               strncpy(pszName, hManager->szZLFile, uSize);
> +               strncpy(pszName, hManager->szZLFile, uSize);
>         else
>                 status = DSP_EFAIL;
> 
[...]

>         struct DBLLAlloc *pAlloc = (struct DBLLAlloc *)this;
>         struct DBLL_LibraryObj *lib;
> @@ -1471,13 +1471,14 @@ static int writeMem(struct Dynamic_Loader_Initialize *this, void *buf,
> 
>         DBC_Require(this != NULL);
>         lib = pInit->lib;
> -       DBC_Require(MEM_IsValidHandle(lib, DBLL_LIBSIGNATURE));
> +       if (!MEM_IsValidHandle(lib, DBLL_LIBSIGNATURE))
> +               return false;

int returning function getting false?? should'nt u be using something 
like -EINVALID or -ENOMEM?

> +
> +       pTarget = lib->pTarget;

HUH?? you just introduced a bug! if lib was NULL?? BOOM..
> 
>         memType = (DLOAD_SECTION_TYPE(info->type) == DLOAD_TEXT) ? DBLL_CODE :
>                   DBLL_DATA;
> -       if ((lib != NULL) &&
> -           ((pTarget = lib->pTarget) != NULL) &&
> -           (pTarget->attrs.write != NULL)) {
> +       if (lib && pTarget && pTarget->attrs.write) {

note: the logic changes with your implementation.. unfortunately in 
favor of a buggy one.

> diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
> index 7ec1ccc..d455c5b 100644
> --- a/drivers/dsp/bridge/rmgr/drv.c
> +++ b/drivers/dsp/bridge/rmgr/drv.c
> @@ -888,7 +888,7 @@ DSP_STATUS DRV_Init(void)
>   *      Insert a DevObject into the list of Manager object.
>   */
>  DSP_STATUS DRV_InsertDevObject(struct DRV_OBJECT *hDRVObject,
> -                              struct DEV_OBJECT *hDevObject)
> +                               struct DEV_OBJECT *hDevObject)
>  {
>         DSP_STATUS status = DSP_SOK;
>         struct DRV_OBJECT *pDRVObject = (struct DRV_OBJECT *)hDRVObject;
> @@ -919,7 +919,7 @@ DSP_STATUS DRV_InsertDevObject(struct DRV_OBJECT *hDRVObject,
>   *      objects.
>   */
>  DSP_STATUS DRV_RemoveDevObject(struct DRV_OBJECT *hDRVObject,
> -                              struct DEV_OBJECT *hDevObject)
> +                               struct DEV_OBJECT *hDevObject)
>  {
>         DSP_STATUS status = DSP_EFAIL;
>         struct DRV_OBJECT *pDRVObject = (struct DRV_OBJECT *)hDRVObject;
> @@ -1001,7 +1001,7 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
>                 *pDevNodeString = 0;
>         }
> 
> -       if (!(strcmp((char *) dwContext, "TIOMAP1510"))) {
> +       if (!(strcmp((char *) dwContext, "TIOMAP1510"))) {

Do we really support these?? but my comment is out of scope here though..

>                 GT_0trace(curTrace, GT_1CLASS,
>                           " Allocating resources for UMA \n");
>                 status = RequestBridgeResourcesDSP(dwContext, DRV_ASSIGN);
> @@ -1034,7 +1034,7 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
> 
>         GT_0trace(curTrace, GT_ENTER, "Entering DRV_Release Resources\n");
> 
> -       if (!(strcmp((char *)((struct DRV_EXT *)dwContext)->szString,
> +       if (!(strcmp((char *)((struct DRV_EXT *)dwContext)->szString,
>            "TIOMAP1510"))) {
>                 GT_0trace(curTrace, GT_1CLASS,
>                          " Releasing DSP-Bridge resources \n");
> @@ -1149,10 +1149,10 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
>                                 iounmap(pResources->dwDmmuBase);
>                         if (pResources->dwPerBase)
>                                 iounmap(pResources->dwPerBase);
> -                       if (pResources->dwPerPmBase)
> -                               iounmap((void *)pResources->dwPerPmBase);
> -                       if (pResources->dwCorePmBase)
> -                               iounmap((void *)pResources->dwCorePmBase);
> +                       if (pResources->dwPerPmBase)
> +                               iounmap((void *)pResources->dwPerPmBase);
> +                       if (pResources->dwCorePmBase)
> +                               iounmap((void *)pResources->dwCorePmBase);
I assume something white space changed here...

>                         if (pResources->dwSysCtrlBase) {
>                                 iounmap(pResources->dwSysCtrlBase);
>                                 /* don't set pResources->dwSysCtrlBase to null
> @@ -1284,10 +1284,10 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
>                                                         OMAP_DSP_MEM3_SIZE);
>                 pResources->dwPerBase = ioremap(OMAP_PER_CM_BASE,
>                                                         OMAP_PER_CM_SIZE);
> -               pResources->dwPerPmBase = ioremap(OMAP_PER_PRM_BASE,
> -                                                       OMAP_PER_PRM_SIZE);
> -               pResources->dwCorePmBase = (u32)ioremap(OMAP_CORE_PRM_BASE,
> -                                                       OMAP_CORE_PRM_SIZE);
> +               pResources->dwPerPmBase = ioremap(OMAP_PER_PRM_BASE,
> +                                                       OMAP_PER_PRM_SIZE);
> +               pResources->dwCorePmBase = (u32)ioremap(OMAP_CORE_PRM_BASE,
> +                                                       OMAP_CORE_PRM_SIZE);
(casting) is evil usually.. should'nt you be chaning dwCorePmBase to 
__iomem * instead?

[...]

> diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
> index cf9c9a1..0b4e202 100644
> --- a/drivers/dsp/bridge/rmgr/node.c
> +++ b/drivers/dsp/bridge/rmgr/node.c
> @@ -257,9 +257,9 @@ static void FreeStream(struct NODE_MGR *hNodeMgr, struct STREAM stream);
>  static DSP_STATUS GetFxnAddress(struct NODE_OBJECT *hNode, u32 *pulFxnAddr,
>                                 u32 uPhase);
>  static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
> -                              struct NODE_OBJECT *hNode,
> -                              CONST struct DSP_UUID *pNodeId,
> -                              struct DCD_GENERICOBJ *pdcdProps);
> +                               struct NODE_OBJECT *hNode,
> +                               CONST struct DSP_UUID *pNodeId,
> +                               struct DCD_GENERICOBJ *pdcdProps);

Might have been nice if you had posted patches for each step -> e.g. 
removal of CONST... it is easier to review in that sense..


>  static DSP_STATUS GetProcProps(struct NODE_MGR *hNodeMgr,
>                               struct DEV_OBJECT *hDevObject);
>  static DSP_STATUS GetRMSFxns(struct NODE_MGR *hNodeMgr);
> @@ -293,14 +293,13 @@ static struct NLDR_FXNS nldrFxns = {
> 
>  enum NODE_STATE NODE_GetState(HANDLE hNode)
>  {
> -       struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
> -       if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE)) {
> -               GT_1trace(NODE_debugMask, GT_5CLASS,
> -                "NODE_GetState:hNode 0x%x\n", pNode);
> -               return  -1;
> -       } else
> -               return pNode->nState;
> -
> +       struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
> +       if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE)) {
> +               GT_1trace(NODE_debugMask, GT_5CLASS,
> +                               "NODE_GetState:hNode 0x%x\n", pNode);
> +               return  -1;

Generic: use -Exxxx series please..

[...]

> --- a/drivers/dsp/bridge/wmd/io_sm.c
> +++ b/drivers/dsp/bridge/wmd/io_sm.c
[...]
> @@ -232,12 +230,12 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
>                 status = DSP_EMEMORY;
>                 goto func_cont;
>         }
> -       /*Intializing Work Element*/
> -       if (ref_count == 0) {
> -               INIT_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
> -               ref_count = 1;
> -       } else
> -               PREPARE_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
> +       /*Intializing Work Element*/
> +       if (ref_count == 0) {
> +               INIT_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
> +               ref_count = 1;
> +       } else
> +               PREPARE_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
} else {
	PREPARE_WORK - Ref: Documentation/CodingStyle
}
Quote:
Also, note that this brace-placement also minimizes the number of empty
(or almost empty) lines, without any loss of readability.  Thus, as the
supply of new-lines on your screen is not a renewable resource (think
25-line terminal screens here), you have more empty lines to put
comments on.

Do not unnecessarily use braces where a single statement will do.

if (condition)
         action();

This does not apply if one branch of a conditional statement is a single
statement. Use braces in both branches.

if (condition) {
         do_this();
         do_that();
} else {
         otherwise();
}


> 
>         /* Initialize CHNL_MGR object:    */
>  #ifndef DSP_TRACEBUF_DISABLED
> @@ -269,18 +267,15 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
>                 if (devType == DSP_UNIT) {
>                         HW_MBOX_initSettings(hostRes.dwMboxBase);
>                         /* Plug the channel ISR:. */
> -                       if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
> -                               "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
> -                               status = DSP_SOK;
> -                       else
> -                               status = DSP_EFAIL;
> +                       if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
> +                         "DspBridge\tmailbox", (void *)pIOMgr)) == 0) {
> +                               status = DSP_SOK;
> +                               DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
> +                                               pIOMgr);
> +                       } else
> +                               status = CHNL_E_ISR;
>                 }
> -       if (DSP_SUCCEEDED(status))
> -               DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
> -                               pIOMgr);
> -       else
> -               status = CHNL_E_ISR;
> -       } else
> +       } else
>                 status = CHNL_E_ISR;

same here.

[..]

> @@ -1516,13 +1509,13 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
>                 pMsgOutput = pIOMgr->pMsgOutput;
>                 /* Copy uMsgs messages into shared memory */
>                 for (i = 0; i < uMsgs; i++) {
> -                       if (!hMsgMgr->msgUsedList) {
> -                               DBG_Trace(DBG_LEVEL3, "msgUsedList is NULL\n");
> -                               pMsg = NULL;
> -                               goto func_end;
> -                       } else
> -                               pMsg = (struct MSG_FRAME *)LST_GetHead(
> -                                       hMsgMgr->msgUsedList);
> +                       if (!hMsgMgr->msgUsedList) {
> +                               DBG_Trace(DBG_LEVEL3, "msgUsedList is NULL\n");
> +                               pMsg = NULL;
> +                               goto func_end;
> +                       } else
> +                               pMsg = (struct MSG_FRAME *)LST_GetHead(
> +                                       hMsgMgr->msgUsedList);
Ditto.
[...]
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> index dc20684..f5eb21c 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> @@ -547,14 +547,18 @@ DSP_STATUS DSP_PeripheralClocks_Disable(struct WMD_DEV_CONTEXT *pDevContext,
>                         status = CLK_Disable(BPWR_Clks[clkIdx].intClk);
>                         if (BPWR_CLKID[clkIdx] == BPWR_MCBSP1) {
>                                 /* clear MCBSP1_CLKS, on McBSP1 OFF */
> -                               value = __raw_readl(pDevContext->sysctrlbase + 0x274);
> +                               value = __raw_readl(pDevContext->sysctrlbase
> +                                                               + 0x274);
>                                 value &= ~(1 << 2);
> -                               __raw_writel(value, pDevContext->sysctrlbase + 0x274);
> +                               __raw_writel(value, pDevContext->sysctrlbase
> +                                                               + 0x274);
>                         } else if (BPWR_CLKID[clkIdx] == BPWR_MCBSP2) {
>                                 /* clear MCBSP2_CLKS, on McBSP2 OFF */
> -                               value = __raw_readl(pDevContext->sysctrlbase + 0x274);
> +                               value = __raw_readl(pDevContext->sysctrlbase
> +                                                               + 0x274);
>                                 value &= ~(1 << 6);
> -                               __raw_writel(value, pDevContext->sysctrlbase + 0x274);
> +                               __raw_writel(value, pDevContext->sysctrlbase
> +                                                               + 0x274);
Flags go up.. are we hitting ARM's clock registers directly? could'nt we 
use the clk framework?? just query.. how do you ensure that ARM usage of 
McBSP2 does not conflict with DSP McBSP2?

[...]
> diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
> index 658cd73..6d6c76b 100644
> --- a/drivers/dsp/bridge/wmd/ue_deh.c
> +++ b/drivers/dsp/bridge/wmd/ue_deh.c
> @@ -107,11 +107,11 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
>                         pDehMgr->errInfo.dwVal2 = 0L;
>                         pDehMgr->errInfo.dwVal3 = 0L;
>                         /* Install ISR function for DSP MMU fault */
> -                       if ((request_irq(INT_DSP_MMU_IRQ, MMU_FaultIsr, 0,
> -                                           "DspBridge\tiommu fault", (void *)pDehMgr)) == 0)
> -                               status = DSP_SOK;
> -                       else
> -                               status = DSP_EFAIL;
> +                       if ((request_irq(INT_DSP_MMU_IRQ, MMU_FaultIsr, 0,
> +                          "DspBridge\tiommu fault", (void *)pDehMgr)) == 0)

Try using !(request_irq) instead of request_irq == 0  perhaps?

> +                               status = DSP_SOK;
> +                       else
> +                               status = DSP_EFAIL;

:( makes me wonder about why errno.h.. then I tell myself.. legacy luggage..

phew.. reached the end.. :)..

-- 
Regards,
Nishanth Menon
